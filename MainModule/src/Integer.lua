--------------------------------------------------------------------------------------------------------------------------------
--[[                                             Copyright (C) Inertia Lighting                                             ]]--
--------------------------------------------------------------------------------------------------------------------------------

local Integer = {}

--------------------------------------------------------------------------------------------------------------------------------

--- Divides a number and returns the floor and ceil of the result as a tuple
--- @param input number
--- @param divisor number
--- @returns floor number, ceil number
--- ```lua
--- local smaller, larger = Integer.divide(7, 2)
--- print(smaller, larger) -- 3, 4
--- ```
function Integer.divide(input, divisor)
    if divisor == 0 then
        error('LA.Integer.divide: divisor cannot be 0')
    end

    local result = input / divisor

    return math.floor(result), math.ceil(result)
end

--------------------------------------------------------------------------------------------------------------------------------

return Integer
