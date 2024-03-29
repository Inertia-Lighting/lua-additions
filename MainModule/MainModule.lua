--------------------------------------------------------------------------------------------------------------------------------
--[[                                             Copyright (C) Inertia Lighting                                             ]]--
--------------------------------------------------------------------------------------------------------------------------------

local LuaAdditions = {}

---------------------------------------------------------------

LuaAdditions.version = 'v0.0.4-beta'

---------------------------------------------------------------

local srcFolder = script:WaitForChild('src', 5)
if not srcFolder then
    error('LuaAdditions: failed to load src folder')
    return
end

---------------------------------------------------------------

LuaAdditions.Table = require(srcFolder.Table)

LuaAdditions.String = require(srcFolder.String)

LuaAdditions.Number = require(srcFolder.Number)

LuaAdditions.Integer = require(srcFolder.Integer)

LuaAdditions.Utility = require(srcFolder.Utility)

LuaAdditions.Collection = require(srcFolder.Collection)

LuaAdditions.Color = require(srcFolder.Color)

---------------------------------------------------------------

return LuaAdditions
