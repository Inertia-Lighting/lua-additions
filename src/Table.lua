local Table = {}

--------------------------------------------------------------------------------------------------------------------------------

--- Clones a table and returns the clone
--- @param tbl table
--- @returns cloned table
function Table.clone(tbl)
    local cloned = { table.unpack(tbl) }

    return cloned
end

--- Combines all values from a table into a new string spaced by a separator
--- @param tbl table
--- @param separator string
--- @returns str string
function Table.join(tbl, separator)
    local str = ''

    for index, value in ipairs(tbl) do
        str = str .. tostring(value) .. (index < #tbl and (separator or ',') or '')
    end

    return str
end

--- Clones a slice from the table starting at the (startIndex or 1) up to the (endIndex or #tbl)
--- @param tbl table
--- @param startIndex number
--- @param endIndex number
--- @returns sliced table
function Table.slice(tbl, startIndex, endIndex)
    local sliced = {}

    for index = startIndex or 1, endIndex or #tbl, 1 do
        sliced[#sliced + 1] = tbl[index]
    end

    return sliced
end

--- Iterates over a table providing a callback function to alter each value
--- @param tbl table
--- @param callback function callback(value, key, tbl)
--- @returns mapped table
function Table.map(tbl, callback)
    local mapped = {}

    for key, value in pairs(tbl) do
        mapped[key] = callback(value, key, tbl)
    end

    return mapped
end

--- Iterates over a table to reduce it to a single value by providing a callback function to alter an accumulated value
--- @param tbl table
--- @param callback function callback(accumulator, value, index, tbl)
--- @param initialValue any forces an initial value for the accumulator
--- @returns accumulator any
function Table.reduce(tbl, callback, initialValue)
    local accumulator = initialValue or nil

    for index, value in ipairs(tbl) do
        accumulator = (index == 1 and initialValue == nil) and value or callback(accumulator, value, index, tbl)
    end

    return accumulator
end

--- Iterates over a table's values and indexes
--- @param tbl table
--- @param callback function callback(value, index, tbl)
--- @returns tbl table
function Table.forEachIndex(tbl, callback)
    for index, value in ipairs(tbl) do
        callback(value, index, tbl)
    end

    return tbl
end

--- Iterates over a table's values and keys
--- @param tbl table
--- @param callback function callback(value, key, tbl)
--- @returns tbl table
function Table.forEachKey(tbl, callback)
    for key, value in pairs(tbl) do
        callback(value, key, tbl)
    end

    return tbl
end

--- Checks if the table includes valueToFind
--- @param tbl table
--- @param valueToFind any
--- @returns included boolean
function Table.includes(tbl, valueToFind)
    local included = false

    for _, value in ipairs(tbl) do
        if value == valueToFind then
            included = true
        end
    end

    return included
end

--- Finds the first value in a table that satisfies the callback function
--- @param tbl table
--- @param callback function callback(value, key, tbl)
--- @returns matched any
function Table.find(tbl, callback)
    local matched = nil

    for key, value in pairs(tbl) do
        if callback(value, key, tbl) then
            matched = value
            break
        end
    end

    return matched
end

--- Finds all values in a table that satisfy the callback function
--- @param tbl table
--- @param callback function callback(value, key, tbl)
--- @returns matches table
function Table.filter(tbl, callback)
    local matches = {}

    for key, value in pairs(tbl) do
        if callback(value, key, tbl) then
            matches[#matches + 1] = value
        end
    end

    return matches
end

--- Clones the table and reverses the order of the values
--- @param tbl table
--- @returns reversed table
function Table.reverse(tbl)
    local reversed = {}

    for index = #tbl, 1, -1 do
        reversed[#reversed + 1] = tbl[index]
    end

    return reversed
end

--- Prepends the values from tableToPrepend into tbl
--- @param tbl table
--- @param tableToPrepend table
--- @returns tbl table
function Table.prepend(tbl, tableToPrepend)
    for index = #tbl, 1, -1 do
        tbl[index + #tableToPrepend] = tbl[index]
    end

    for index, value in ipairs(tableToPrepend) do
        tbl[index] = value
    end

    return tbl
end

--- Appends the values from tableToAppend into tbl
--- @param tbl table
--- @param tableToAppend table
--- @returns tbl table
function Table.append(tbl, tableToAppend)
    for _, value in ipairs(tableToAppend) do
        tbl[#tbl + 1] = value
    end

    return tbl
end

--------------------------------------------------------------------------------------------------------------------------------

return Table
