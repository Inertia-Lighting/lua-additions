--------------------------------------------------------------------------------------------------------------------------------
--[[                                             Copyright (C) Inertia Lighting                                             ]]--
--------------------------------------------------------------------------------------------------------------------------------

local Utility = {}

--------------------------------------------------------------------------------------------------------------------------------

--- Basic switch statement for lua that supports having a return value
--- @param condition any the condition to look for within the cases table
--- @param cases table a table of cases to map conditions and cases to
--- @param strict boolean whether or not to throw an error if a default case was not found
--- @returns any the the value returned by the case that was executed
function Utility.switch(condition, cases, strict)
    if type(cases) ~= 'table' then
        error('LA.Utility.switch: cases must be a table')
    end

    local specifiedCase = nil
    for caseCondition in pairs(cases) do
        if caseCondition == condition then
            specifiedCase = cases[caseCondition]
            break
        end
    end

    local defaultCase = cases['default']

    if strict and not defaultCase then
        error('LA.Utility.switch: case [\'default\'] must be present when \'strict\' is true')
    end

    local case = specifiedCase or defaultCase or (function() return nil end)

    if type(case) ~= 'function' then
        error('LA.Utility.switch: case:' .. tostring(condition) .. 'must be a function')
    end

    return case() or nil
end

--- Implements a basic try-catch block for lua
--- @param func function the function to try via pcall
--- @returns t table a table containing a chain-able ':catch(cb?)' callback
function Utility.try(func)
    if type(func) ~= 'function' then
        error('LA.Utility.try: func must be a function')
    end

    local t = {}

    local success, result = pcall(func)

    function t:catch(func2)
        if func2 ~= nil and type(func2) ~= 'function' then
            error('LA.Utility.try.catch: func2 must be a function when specified')
        end

        if success then return result end

        return func2 and func2(result) or nil
    end

    return t
end

--- Implements a batched validation function for checking conditions
--- @param table table of items that you want to check
--- @param expected the expected value of all the ietms in the table
--- @returns Boolean The result of if all the items in the table are equal to the expected result
function Utility.validate(table, expected)
    if type(table) ~= 'table' then
        error('LA.Utility.validate: table must be a table')
    end
    
    local result = true

    for _,item in pairs(table) do
        if item ~= expected then
            return false
        end
    end
    
    return true
end

--------------------------------------------------------------------------------------------------------------------------------

return Utility