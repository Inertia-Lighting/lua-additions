--------------------------------------------------------------------------------------------------------------------------------
--[[                                             Copyright (C) Inertia Lighting                                             ]]--
--------------------------------------------------------------------------------------------------------------------------------

local Integer = {}

--------------------------------------------------------------------------------------------------------------------------------

--- Divides and returns the floor and ceil of a quotient as a tuple.
--- @param dividend number
--- @param divisor number
--- @returns quotientFloor number, quotientCeil number
--- ```lua
--- local qMin, qMax = Integer.divide(10, 3)
--- print(qMin, qMax) -- 3, 4
--- ```
function Integer.divide(dividend, divisor)
    if divisor == 0 then
        error('LA.Integer.divide: divisor cannot be 0')
    end

    local result = dividend / divisor

    return math.floor(result), math.ceil(result)
end

--------------------------------------------------------------------------------------------------------------------------------

return Integer
