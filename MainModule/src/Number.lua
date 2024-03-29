--------------------------------------------------------------------------------------------------------------------------------
--[[                                             Copyright (C) Inertia Lighting                                             ]]--
--------------------------------------------------------------------------------------------------------------------------------

local Number = {}

--------------------------------------------------------------------------------------------------------------------------------

--- Checks if a number is odd
--- @param num number
--- @returns boolean
function Number.isOdd(num)
    return num % 2 ~= 0
end

--- Checks if a number is even
--- @param num number
--- @returns boolean
function Number.isEven(num)
    return num % 2 == 0
end

--------------------------------------------------------------------------------------------------------------------------------

return Number
