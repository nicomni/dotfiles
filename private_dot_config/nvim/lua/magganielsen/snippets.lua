-- Usefull for development
-- require("luasnip.session.snippet_collection").clear_snippets("go")
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta

local types = require("luasnip.util.types")

--- @return TSNode|nil
local function get_parent_fn_declaration()
  local node = vim.treesitter.get_node()

  local lookup = {
    function_declaration = true,
    method_declaration = true,
    func_literal = true,
  }

  while node ~= nil do
    if lookup[node:type()] then
      break
    end

    node = node:parent()
  end

  if not node then
    return
  end

  return node
end

ls.setup({
  history = true,
  ext_opts = {
    [types.snippet] = {
      active = {
        hl_group = "DiagnosticError",
      },
      passive = {
        hl_group = "DiagnosticInfo",
      },
    },
  },
})

local calculate_return_value = {

  error = function(err_name)
    return err_name
  end,

  default = function(_)
    return ""
  end,
}

local function get_node_text(node)
  return vim.treesitter.get_node_text(node, 0)
end

---@class GoReturnValueInfo
---@field needs_zero_value boolean
---@field zero_value_reference string
---@field type_text string

-- TODO: Write a function that takes a TSNode which `:type()` is one of:
--   * array_type
--   * channel_type
--   * function_type
--   * generic_type
--   * interface_type
--   * map_type
--   * pointer_type
--   * qualified_type
--   * slice_type
--   * struct_type
--   * type_identifier
-- or a parameter_list (consisting of a sequence of one or more of the above.)
-- The function should return a list-like of `GoReturnValueInfo` objects in the
-- same order as in the parameter_list.

---@param node TSNode
---@return GoReturnValueInfo[]|GoReturnValueInfo
local function analyze_result_field(node, err_name)
  ---@param n TSNode
  local function type_name(n)
    if n:type() == "generic_type" then
      return get_node_text(n:field("type")[1])
    end
    if n:type() == "qualified_type" then
      return get_node_text(n:field("name")[1])
    end
    if n:type() == "struct_type" then
      return "struct"
    end
    if n:type() == "type_identifier" then
      return get_node_text(n)
    end
    return ""
  end

  if node:type() == "parameter_list" then
    local zero_nodes = {}
    local node_infos = {}

    for result_child in node:iter_children() do
      if not result_child:named() then
        goto continue
      end
      local parameter_decl = result_child
      local type_node = parameter_decl:field("type")[1]
      local info = analyze_result_field(type_node, err_name)
      table.insert(node_infos, info)
      if info.needs_zero_value then
        table.insert(zero_nodes, info)
      end
      ::continue::
    end

    if #zero_nodes == 1 then
      zero_nodes[1].zero_value_reference = "zero"
    end
    return node_infos
  end

  local need_zero_initializer = {
    generic_type = true,
    qualified_type = true,
    struct_type = true,
    type_identifier = true,
  }

  local numeric = {
    int = true,
    int8 = true,
    int16 = true,
    int32 = true,
    int64 = true,
    uint = true,
    uint8 = true,
    uint16 = true,
    uint32 = true,
    uint64 = true,
    uintptr = true,
    byte = true,
    rune = true,
    float32 = true,
    float64 = true,
    complex64 = true,
    complex128 = true,
  }

  if node:type() == "type_identifier" then
    local t = get_node_text(node)
    if t == "error" then
      vim.notify(string.format("err_name in analyze_result_field: %s", err_name))
      return {
        need_zero_value = false,
        zero_value_reference = err_name,
        type_text = "error",
      }
    elseif t == "bool" then
      return {
        need_zero_value = false,
        zero_value_reference = "false",
        type_text = "bool",
      }
    elseif t == "string" then
      return {
        need_zero_value = false,
        zero_value_reference = '""',
        type_text = "string",
      }
    elseif numeric[t] then
      return {
        need_zero_value = false,
        zero_value_reference = "0",
        type_text = t,
      }
    end
  end

  if need_zero_initializer[node:type()] then
    return {
      needs_zero_value = true,
      zero_value_reference = "zero" .. (type_name(node):gsub("^%l", string.upper)),
      type_text = get_node_text(node),
    }
  end

  return {
    needs_zero_value = false,
    zero_value_reference = "nil",
    type_text = get_node_text(node),
  }
end

-- TODO: Write a function that takes a GoReturnValueInfo|GoReturnValueInfo[]
-- object and returns a table of strings. For each unique
-- info.zero_value_reference, add a string like var <zero_value_reference>
-- <type_text>. The last string should be a return statement in Go language
-- that returns the zero value for each item. Example: "return zeroMyType,
-- zeroMySecondType"
local function generate_zero_initializers_and_return(infos)
  ---@type GoReturnValueInfo[]
  local infos = vim.islist(infos) and infos or { infos }
  local lines = {}
  local return_values = {}
  local seen = {}
  local is_first = true
  vim.notify(vim.inspect(infos))
  for _, info in ipairs(infos) do
    if info.needs_zero_value and not seen[info.zero_value_reference] then
      local indent = is_first and "" or "  " -- two spaces for indentation
      table.insert(lines, string.format("%svar %s %s", indent, info.zero_value_reference, info.type_text))
      seen[info.zero_value_reference] = true
      is_first = false
    end
    table.insert(return_values, info.zero_value_reference)
  end
  table.insert(lines, "  return " .. table.concat(return_values, ", ")) -- two spaces before 'return' for indentation
  return lines
end

--- @type table<string, fun(node: TSNode, err_name: string): string>
local result_field_handler = {
  --  All possible node types for the result field of a method_declaration, function_declaration or func_literal:
  --  * parameter_list   ☑️
  --  * array_type       ✅
  --  * channel_type     ✅
  --  * function_type    ✅
  --  * generic_type     ☑️
  --  * interface_type   ✅
  --  * map_type         ☑️
  --  * negated_type     ✅
  --  * pointer_type     ✅
  --  * qualified_type   ☑️
  --  * slice_type       ✅
  --  * struct_type      ☑️
  --  * type_identifier  ☑️
  --  * (no result / absent)
  --  Source: https://raw.githubusercontent.com/tree-sitter/tree-sitter-go/refs/tags/v0.25.0/grammar.js

  array_type = function(array_type, _)
    return vim.treesitter.get_node_text(array_type, 0, nil) .. "{}"
  end,

  channel_type = function(_, _)
    return "nil"
  end,

  function_type = function(_, _)
    return "nil"
  end,

  --- HACK: This does not work after insertion, yet. First, we need to create
  --- the zero value for the generic type before entering 'zero'. To do this,
  --- let's assume the generic type is MyType[T]. Then the zero value can be
  --- created in go with `var zero MyType[T]`. Then we can return the `zero`
  --- variable.
  generic_type = function(_, _)
    return "zero"
  end,

  --- HACK: Same problem as generic_type
  qualified_type = function(_, _)
    return "zero"
  end,

  interface_type = function(_, _)
    return "nil"
  end,

  map_type = function(_, _)
    return "nil"
  end,

  pointer_type = function(_, _)
    return "nil"
  end,

  slice_type = function(_, _)
    return "nil"
  end,

  --- TODO: Use var zero instead. The zero value is empty zero struct of struct literal
  struct_type = function(_, _)
    return "zero"
  end,

  --- TODO: User var zero here also
  type_identifier = function(_, _)
    return "zero"
  end,

  parameter_list = function(parameter_list, _)
    for result_child in parameter_list:iter_children() do
      if not result_child:named() then
        goto continue
      end
      local parameter_decl = result_child
      local type = parameter_decl:field("type")[1]
      vim.notify(
        string.format("found parameter of type: %s, for node of type: %s", get_node_text(type), parameter_decl:type())
      )
      ::continue::
    end
    return "parameter_list"
  end,

  default = function(_, _)
    return ""
  end,
}

local need_zero_initializer = {
  generic_type = true,
  qualified_type = true,
  struct_type = true,
  type_identifier = true,
}

local function initialize_zero(node)
  if need_zero_initializer[node:type()] then
    return string.format("var zero %s", get_node_text(node))
  end
  return ""
end

---@param args? string[][] the text currently contained each line of the referenced nodes
---@return table<string>
local function go_return_values_on_error(args)
  if not args then
    return { "" }
  end
  local err_name = args[1][1]
  vim.notify(string.format("err_name in go_return_values_on_error: %s", err_name))
  local node = get_parent_fn_declaration()
  if not node then
    vim.notify("Not inside a function", vim.log.levels.WARN)
    return { "" }
  end
  local result_fields = node:field("result")
  if #result_fields == 0 then
    vim.notify("No result parameters!")
    return { "" }
  end
  if #result_fields > 1 then
    vim.notify(string.format("Expected 1 result field, found: %d", #result_fields), vim.log.levels.ERROR)
    return { "" }
  end
  local result_field = result_fields[1]
  local output = initialize_zero(result_field)
  local return_info = analyze_result_field(result_field, err_name)
  -- local result_handler = result_field_handler[result_field:type()] or result_field_handler["default"]
  return generate_zero_initializers_and_return(return_info)
end

--   [[
--   ; query
--   [
--     (method_declaration result: _ @return.parameters)
--     (function_declaration result: _ @return.parameters)
--     (func_literal result: _ @return.parameters)
--   ]
--   ]]
-- )

ls.add_snippets("go", {
  s(
    "efi",
    fmta(
      [[
      <val>, <err_name> := <fn_name>(<args>)
      if <err_name> != nil {
        <result>
      }
      <finish>
    ]],
      {
        val = i(1),
        err_name = i(2, "err"),
        fn_name = i(3),
        args = i(4),
        result = f(go_return_values_on_error, 2),
        finish = i(0),
      },
      {
        repeat_duplicates = true,
      }
    )
  ),
})
