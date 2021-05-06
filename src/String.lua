local String = {}

--------------------------------------------------------------------------------------------------------------------------------

--- Splits a string by a separator (',' by default) into a table containing substrings
--- @param str string
--- @param separator string
--- @returns strs table
function String.split(str, separator)
    separator = separator or ','

    if string.len(str) == 0 then
        return { str }
    end

    local strs = {}

    for match in string.gmatch(str, string.format('([^%s]+)', separator, separator)) do
        table.insert(strs, match)
    end

    return strs
end

--------------------------------------------------------------------------------------------------------------------------------

return String
