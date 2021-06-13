local LuaAdditions = {}

---------------------------------------------------------------

local srcFolder = script.Parent:WaitForChild('src')

LuaAdditions.Table = require(srcFolder.Table)

LuaAdditions.String = require(srcFolder.String)

---------------------------------------------------------------

return LuaAdditions
