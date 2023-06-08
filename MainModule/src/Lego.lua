--------------------------------------------------------------------------------------------------------------------------------
--[[                                             Copyright (C) Inertia Lighting                                             ]]--
--------------------------------------------------------------------------------------------------------------------------------

local Lego = {}

--------------------------------------------------------------------------------------------------------------------------------

-- This is to avoid namespace collisions with Roblox
Lego.Instance = {}

--- Creates a new instance with a given or generated name.
--- @param className string the name of the class to create an instance of.
--- @param nameOrNameGenerator string|function the name to give the instance or a function that returns a name.
--- @returns Instance The instance that was created.
--- @throws error if unable to create the instance.
function Lego.Instance.create(className, nameOrNameGenerator)
    local success, instance = pcall(function()
        return Instance.new(className)
    end)

    if (not success) or (not instance) then
        error("Failed to create instance: " .. instance)
    end

    if type(nameOrNameGenerator) == "function" then
        instance.Name = nameOrNameGenerator()
    elseif type(nameOrNameGenerator) == "string" then
        instance.Name = nameOrNameGenerator
    else
        error("LA.Lego.Instance.create(): nameOrNameGenerator must be a string or function")
    end

    return instance
end

--------------------------------------------------------------------------------------------------------------------------------

return Lego
