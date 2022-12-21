--[[
--      TYPES
--]]

--- @class PackerSpec
--- @field [1] string The plugin location string

--- @class Module
--- @field packages table<string,PackerSpec> Table of packer plugins specs
--- @field configs table<string,function>
--- @field binds table
