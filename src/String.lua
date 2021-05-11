local String = {}

--------------------------------------------------------------------------------------------------------------------------------

--- Repeats a string a specified number of times
--- @param str string
--- @param num number the number of times to repeat 'str' (default: 1)
--- @returns repeated string
function String.replicate(str, num)
    local repeated = str

    for _ = 1, num or 1, 1 do
        repeated = repeated .. str
    end

    return repeated
end

--- Reverses a string
--- @param str string
--- @returns reversed string
function String.reverse(str)
    local reversed = ''

    for index = #str, 1, -1 do
        reversed = reversed .. string.sub(str, index, index)
    end

    return reversed
end

--- Removes all whitespace from the beginning and end of a string
--- @param str string
--- @returns trimmed string
function String.trim(str)
    local trimmed = str:gsub("^%s*(.-)%s*$", "%1")

    return trimmed
end

--- Returns the character found at the specified index
--- @param str string
--- @param index number
--- @returns char string
function String.charAt(str, index)
    local char = string.sub(str, index, index)

    return char
end

--- Returns the character code of the character found at the specified index
--- @param str string
--- @param index number
--- @returns charCode number
function String.charCodeAt(str, index)
    local charCode = string.byte(string.sub(str, index, index))

    return charCode
end

--- Splits a string by a separator (example: ',') into a table containing substrings
--- @param str string
--- @param separator string
--- @returns split table
function String.split(str, separator)
    if #str == 0 or not separator then
        return { str }
    end

    local chars = {}
    for index = 1, #str do
        chars[#chars + 1] = string.sub(str, index, index)
    end

    if #separator == 0 then
        return chars
    end

    local currentSplitIndex = 1
    local split = {}

    local charsIndex = 1
    while charsIndex <= #chars do
        local separatorSegment = ''
        local charsSegment = ''
        for separatorIndex = 1, #separator do
            local char = chars[charsIndex]

            charsSegment = charsSegment .. char
            separatorSegment = string.sub(separator, 1, separatorIndex)

            if charsSegment ~= separatorSegment then
                split[currentSplitIndex] = (split[currentSplitIndex] or '') .. char
                break
            end

            if charsSegment == separator then
                split[currentSplitIndex] = (split[currentSplitIndex] or '')
                currentSplitIndex = currentSplitIndex + 1
            end
        end

        if charsIndex == #chars and charsSegment == separator then
            split[#split + 1] = ''
        end

        charsIndex = charsIndex + #charsSegment
    end

    return split
end

--------------------------------------------------------------------------------------------------------------------------------

return String
