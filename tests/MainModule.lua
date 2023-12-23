----------------------------------------------------------------
--[[             Copyright (C) Inertia Lighting             ]]--
----------------------------------------------------------------

local testsFolder = script.Parent
local rootFolder = testsFolder.Parent

local LA = require(rootFolder.MainModule)

----------------------------------------------------------------

------------
-- LA.String
------------

do
    print("Testing: LA.String")

    local testString = " this is a test of a complex, and well designed string. Well that's what I think at least. Hey look, another comma! "

    do
        print("Testing: LA.String.replicate")

        local testStringReplicatedZeroTimes = LA.String.replicate(testString, 0)
        assert(testStringReplicatedZeroTimes == testString, "Failed to replicate string 0 times")

        local testStringReplicatedOnce = LA.String.replicate(testString, 1)
        assert(testStringReplicatedOnce == testString .. testString, "Failed to replicate string 1 time")

        local testStringReplicatedTwice = LA.String.replicate(testString, 2)
        assert(testStringReplicatedTwice == testString .. testString .. testString, "Failed to replicate string 2 times")
    end

    do
        print("Testing: LA.String.reverse")

        local testStringReversed = LA.String.reverse(testString)

        local testStringReversedReference = ""
        for i = #testString, 1, -1 do
            testStringReversedReference = testStringReversedReference .. string.sub(testString, i, i)
        end

        assert(testStringReversed == testStringReversedReference, "Failed to reverse string")
    end

    do
        print("Testing: LA.String.trim")

        local testStringTrimmed = LA.String.trim(testString)

        local testStringTrimmedReference = testString:gsub("^%s*(.-)%s*$", "%1")

        assert(testStringTrimmed == testStringTrimmedReference, "Failed to trim string")
    end

    do
        print("Testing: LA.String.charAt")

        local testStringCharAtPositive5Reference = string.sub(testString, 5, 5)
        local testStringCharAtPositive5 = LA.String.charAt(testString, 5)
        assert(testStringCharAtPositive5 == testStringCharAtPositive5Reference, "Failed to retrieve char from index 5 in string")

        local testStringCharAtNegative5Reference = string.sub(testString, -5, -5)
        local testStringCharAtNegative5 = LA.String.charAt(testString, -5)
        assert(testStringCharAtNegative5 == testStringCharAtNegative5Reference, "Failed to retrieve char from index -5 in string")
    end

    do
        print("Testing: LA.String.charCodeAt")

        local testStringCharCodeAtPositive5Reference = string.byte(string.sub(testString, 5, 5))
        local testStringCharCodeAtPositive5 = LA.String.charCodeAt(testString, 5)
        assert(testStringCharCodeAtPositive5 == testStringCharCodeAtPositive5Reference, "Failed to retrieve char code from index 5 in string")

        local testStringCharCodeAtNegative5Reference = string.byte(string.sub(testString, -5, -5))
        local testStringCharCodeAtNegative5 = LA.String.charCodeAt(testString, -5)
        assert(testStringCharCodeAtNegative5 == testStringCharCodeAtNegative5Reference, "Failed to retrieve char code from index -5 in string")
    end

    do
        print("Testing: LA.String.split")

        local testStringSplitReferenceString = "a,b,c,test,1,2,3"
        local testStringSplitReferenceTable = {"a", "b", "c", "test", "1", "2", "3"}

        local testStringSplitString = LA.String.split(testStringSplitReferenceString, ",")

        for i, v in ipairs(testStringSplitString) do
            assert(v == testStringSplitReferenceTable[i], "Failed to split string at index: " .. tostring(i))
        end
    end
end

-----------
-- LA.Table
-----------

do
    print("Testing: LA.Table")

    local stringTable = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j"}
    local numberTable = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
    local mixedTable = {"a", 1, "b", 2, "c", 3, "d", 4, "e", 5}

    do
        print("Testing: LA.Table.clone")

        local clonedStringTable = LA.Table.clone(stringTable)
        local clonedNumberTable = LA.Table.clone(numberTable)
        local clonedMixedTable = LA.Table.clone(mixedTable)

        for i, v in ipairs(stringTable) do
            assert(v == clonedStringTable[i], "Failed to clone string table, test failed at index: " .. tostring(i))
        end

        for i, v in ipairs(numberTable) do
            assert(v == clonedNumberTable[i], "Failed to clone number table, test failed at index: " .. tostring(i))
        end

        for i, v in ipairs(mixedTable) do
            assert(v == clonedMixedTable[i], "Failed to clone mixed table, test failed at index: " .. tostring(i))
        end
    end

    do
        print("Testing: LA.Table.join")

        assert(LA.Table.join(stringTable, ",") == "a,b,c,d,e,f,g,h,i,j", "Failed to join string table using commas")
        assert(LA.Table.join(numberTable, ",") == "1,2,3,4,5,6,7,8,9,10", "Failed to join number table using commas")
        assert(LA.Table.join(mixedTable, ",") == "a,1,b,2,c,3,d,4,e,5", "Failed to join mixed table using commas")
    end

    do
        print("Testing: LA.Table.slice")

        local startIndex = 2
        local endIndex = 7

        local slicedStringTable = LA.Table.slice(stringTable, startIndex, endIndex)
        local slicedNumberTable = LA.Table.slice(numberTable, startIndex, endIndex)
        local slicedMixedTable = LA.Table.slice(mixedTable, startIndex, endIndex)

        for i, v in ipairs(slicedStringTable) do
            assert(v == stringTable[i + startIndex - 1], "Failed to slice string table, test failed at index: " .. tostring(i))
        end

        for i, v in ipairs(slicedNumberTable) do
            assert(v == numberTable[i + startIndex - 1], "Failed to slice number table, test failed at index: " .. tostring(i))
        end

        for i, v in ipairs(slicedMixedTable) do
            assert(v == mixedTable[i + startIndex - 1], "Failed to slice mixed table, test failed at index: " .. tostring(i))
        end
    end

    do
        print("Testing: LA.Table.map")

        local function mapFunction(value)
            if type(value) == "number" then
                return value * 2
            else
                return tostring(value) .. tostring(value)
            end
        end

        local mappedStringTable = LA.Table.map(stringTable, mapFunction)
        local mappedNumberTable = LA.Table.map(numberTable, mapFunction)
        local mappedMixedTable = LA.Table.map(mixedTable, mapFunction)

        for i, v in ipairs(mappedStringTable) do
            assert(v == mapFunction(stringTable[i]), "Failed to map string table, test failed at index: " .. tostring(i))
        end

        for i, v in ipairs(mappedNumberTable) do
            assert(v == mapFunction(numberTable[i]), "Failed to map number table, test failed at index: " .. tostring(i))
        end

        for i, v in ipairs(mappedMixedTable) do
            assert(v == mapFunction(mixedTable[i]), "Failed to map mixed table, test failed at index: " .. tostring(i))
        end
    end

    do
        print("Testing: LA.Table.reduce")

        local function reduceFunction(accumulator, value)
            if type(accumulator) == "number" then
                return accumulator + value
            else
                return accumulator .. tostring(value)
            end
        end

        local reducedStringTable = LA.Table.reduce(stringTable, reduceFunction, "")
        local reducedNumberTable = LA.Table.reduce(numberTable, reduceFunction, 0)
        local reducedMixedTable = LA.Table.reduce(mixedTable, reduceFunction, "")

        assert(type(reducedStringTable) == "string", "Failed to reduce string table")
        assert(type(reducedNumberTable) == "number", "Failed to reduce number table")
        assert(type(reducedMixedTable) == "string", "Failed to reduce mixed table")
    end

    do
        print("Testing: LA.Table.forEach")

        local function forEachFunction(value)
            if type(value) == "number" then
                return value * 2
            else
                return tostring(value) .. tostring(value)
            end
        end

        local forEachStringTable = LA.Table.forEach(stringTable, forEachFunction)
        local forEachNumberTable = LA.Table.forEach(numberTable, forEachFunction)
        local forEachMixedTable = LA.Table.forEach(mixedTable, forEachFunction)

        for i, v in ipairs(forEachStringTable) do
            assert(v == forEachFunction(stringTable[i]), "Failed to forEach string table, test failed at index: " .. tostring(i))
        end

        for i, v in ipairs(forEachNumberTable) do
            assert(v == forEachFunction(numberTable[i]), "Failed to forEach number table, test failed at index: " .. tostring(i))
        end

        for i, v in ipairs(forEachMixedTable) do
            assert(v == forEachFunction(mixedTable[i]), "Failed to forEach mixed table, test failed at index: " .. tostring(i))
        end
    end

    do
        print("Testing: LA.Table.includes")

        local itemIndex = 2

        local stringTableItem = stringTable[itemIndex]
        local numberTableItem = numberTable[itemIndex]
        local mixedTableItem = mixedTable[itemIndex]

        assert(LA.Table.includes(stringTable, stringTableItem), "Failed to find string table item")
        assert(LA.Table.includes(numberTable, numberTableItem), "Failed to find number table item")
        assert(LA.Table.includes(mixedTable, mixedTableItem), "Failed to find mixed table item")
    end

    do
        print("Testing: LA.Table.find")

        local itemIndex = 2

        local stringTableItem = stringTable[itemIndex]
        local numberTableItem = numberTable[itemIndex]
        local mixedTableItem = mixedTable[itemIndex]

        local foundStringTableItem = LA.Table.find(stringTable, function(value)
            return value == stringTableItem
        end)
        local foundNumberTableItem = LA.Table.find(numberTable, function(value)
            return value == numberTableItem
        end)
        local foundMixedTableItem = LA.Table.find(mixedTable, function(value)
            return value == mixedTableItem
        end)

        assert(foundStringTableItem == stringTableItem, "Failed to find string table item")
        assert(foundNumberTableItem == numberTableItem, "Failed to find number table item")
        assert(foundMixedTableItem == mixedTableItem, "Failed to find mixed table item")
    end

    do
        print("Testing: LA.Table.filter")

        local filteredMixedTable = LA.Table.filter(mixedTable, function(value)
            return type(value) == "string"
        end)

        for i, v in ipairs(filteredMixedTable) do
            assert(type(v) == "string", "Failed to filter mixed table, test failed at index: " .. tostring(i))
        end
    end

    do
        print("Testing: LA.Table.reverse")

        local reversedStringTable = LA.Table.reverse(stringTable)
        local reversedNumberTable = LA.Table.reverse(numberTable)
        local reversedMixedTable = LA.Table.reverse(mixedTable)

        for i, v in ipairs(reversedStringTable) do
            assert(v == stringTable[#stringTable - i + 1], "Failed to reverse string table, test failed at index: " .. tostring(i))
        end

        for i, v in ipairs(reversedNumberTable) do
            assert(v == numberTable[#numberTable - i + 1], "Failed to reverse number table, test failed at index: " .. tostring(i))
        end

        for i, v in ipairs(reversedMixedTable) do
            assert(v == mixedTable[#mixedTable - i + 1], "Failed to reverse mixed table, test failed at index: " .. tostring(i))
        end
    end

    do
        print("Testing: LA.Table.prepend")

        local tinyStringTable = {"nice", "test"}
        local tinyNumberTable = {60, 9}
        local tinyMixedTable = {69, "test"}

        local prependedStringTable = LA.Table.prepend(tinyStringTable, stringTable)
        local prependedNumberTable = LA.Table.prepend(tinyNumberTable, numberTable)
        local prependedMixedTable = LA.Table.prepend(tinyMixedTable, mixedTable)

        for i, v in ipairs(prependedStringTable) do
            assert(v == stringTable[i + #tinyStringTable], "Failed to prepend string table, test failed at index: " .. tostring(i))
        end

        for i, v in ipairs(prependedNumberTable) do
            assert(v == numberTable[i + #tinyNumberTable], "Failed to prepend number table, test failed at index: " .. tostring(i))
        end

        for i, v in ipairs(prependedMixedTable) do
            assert(v == mixedTable[i + #tinyMixedTable], "Failed to prepend mixed table, test failed at index: " .. tostring(i))
        end
    end

    do
        print("Testing: LA.Table.append")

        local tinyStringTable = {"nice", "test"}
        local tinyNumberTable = {60, 9}
        local tinyMixedTable = {69, "test"}

        local appendedStringTable = LA.Table.append(stringTable, tinyStringTable)
        local appendedNumberTable = LA.Table.append(numberTable, tinyNumberTable)
        local appendedMixedTable = LA.Table.append(mixedTable, tinyMixedTable)

        for i, v in ipairs(appendedStringTable) do
            assert(v == stringTable[i], "Failed to append string table, test failed at index: " .. tostring(i))
            if i > #stringTable then
                assert(v == tinyStringTable[i - #stringTable], "Failed to append string table, test failed at index: " .. tostring(i))
            end
        end

        for i, v in ipairs(appendedNumberTable) do
            assert(v == numberTable[i], "Failed to append number table, test failed at index: " .. tostring(i))
            if i > #numberTable then
                assert(v == tinyNumberTable[i - #numberTable], "Failed to append number table, test failed at index: " .. tostring(i))
            end
        end

        for i, v in ipairs(appendedMixedTable) do
            assert(v == mixedTable[i], "Failed to append mixed table, test failed at index: " .. tostring(i))
            if i > #mixedTable then
                assert(v == tinyMixedTable[i - #mixedTable], "Failed to append mixed table, test failed at index: " .. tostring(i))
            end
        end
    end
end

-------------
-- LA.Utility
-------------

do
    print("Testing: LA.Utility")

    do
        print("Testing LA.Utility.switch")

        local switchInputValue = "case_2"
        local switchReturnValue = "y"

        local value = LA.Utility.switch(
            switchInputValue,
            {
                ["case_1"] = function()
                    return "x"
                end,
                ["case_2"] = function()
                    return switchReturnValue
                end,
                ["case_3"] = function()
                    return "z"
                end,
            },
            true
        )

        assert(value == switchReturnValue, "Failed: " .. tostring(value) .. " should be equal to " .. tostring(switchReturnValue))
    end
end

------------
-- LA.Number
------------

do
    print("Testing: LA.Number")

    local oddNumber = 5
    local evenNumber = 10

    do
        print("Testing: LA.Number.isOdd() with an odd number")

        local isOdd = LA.Number.isOdd(oddNumber)
        assert(isOdd == true, "Failed: " .. oddNumber .. " is an odd number")
    end

    do
        print("Testing: LA.Number.isOdd() with an even number")

        local isOdd = LA.Number.isOdd(evenNumber)
        assert(isOdd == false, "Failed: " .. evenNumber .. " is not an odd number")
    end

    do
        print("Testing: LA.Number.isEven() with an even number")

        local isEven = LA.Number.isEven(evenNumber)
        assert(isEven == true, "Failed: " .. evenNumber .. " is an even number")
    end

    do
        print("Testing: LA.Number.isEven() with an odd number")

        local isEven = LA.Number.isEven(oddNumber)
        assert(isEven == false, "Failed: " .. oddNumber .. " is not an even number")
    end
end

-------------
-- LA.Integer
-------------

do
    print("Testing: LA.Integer")

    do
        print("Testing: LA.Integer.divide")

        local dividend = 10
        local divisor = 3

        local quotientMin = 3
        local quotientMax = 4

        local qMin, qMax = LA.Integer.divide(dividend, divisor)
        assert(qMin == quotientMin, "Failed: " .. tostring(dividend) .. " / " .. tostring(divisor) .. " should produce a minimum quotient of " .. tostring(quotientMin))
        assert(qMax == quotientMax, "Failed: " .. tostring(dividend) .. " / " .. tostring(divisor) .. " should produce a maximum quotient of " .. tostring(quotientMax))
    end
end

-----------
-- LA.Color
-----------

do
    print("Testing: LA.Color")

    local red = 255
    local green = 0
    local blue = 0

    local rgbString = tostring(red) .. ", " .. tostring(green) .. ", " .. tostring(blue)

    local hue = 0
    local saturation = 1
    local value = 1

    local hsvString = tostring(hue) .. ", " .. tostring(saturation) .. ", " .. tostring(value)

    local hexString = "#FF0000"

    do
        print("Testing: LA.Color.rgbToHsv")

        local h, s, v = LA.Color.rgbToHsv(red, green, blue)
        assert(h == hue, "Failed: " .. rgbString .. " should produce a hue of " .. tostring(hue))
        assert(s == saturation, "Failed: " .. rgbString .. " should produce a saturation of " .. tostring(saturation))
        assert(v == value, "Failed: " .. rgbString .. " should produce a value of " .. tostring(value))
    end

    do
        print("Testing: LA.Color.rgbToHex")

        local hex = LA.Color.rgbToHex(red, green, blue)
        assert(hex == hexString, "Failed: " .. rgbString .. " should produce a hex string of " .. hexString)
    end

    do
        print("Testing: LA.Color.hsvToRgb")

        local r, g, b = LA.Color.hsvToRgb(hue, saturation, value)
        assert(r == red, "Failed: " .. hsvString .. " should produce a red value of " .. tostring(red))
        assert(g == green, "Failed: " .. hsvString .. " should produce a green value of " .. tostring(green))
        assert(b == blue, "Failed: " .. hsvString .. " should produce a blue value of " .. tostring(blue))
    end

    do
        print("Testing: LA.Color.hsvToHex")

        local hex = LA.Color.hsvToHex(hue, saturation, value)
        assert(hex == hexString, "Failed: " .. hsvString .. " should produce a hex string of " .. hexString)
    end

    do
        print("Testing: LA.Color.hexToRgb")

        local r, g, b = LA.Color.hexToRgb(hexString)
        assert(r == red, "Failed: " .. hexString .. " should produce a red value of " .. tostring(red))
        assert(g == green, "Failed: " .. hexString .. " should produce a green value of " .. tostring(green))
        assert(b == blue, "Failed: " .. hexString .. " should produce a blue value of " .. tostring(blue))
    end

    do
        print("Testing: LA.Color.hexToHsv")

        local h, s, v = LA.Color.hexToHsv(hexString)
        assert(h == hue, "Failed: " .. hexString .. " should produce a hue of " .. tostring(hue))
        assert(s == saturation, "Failed: " .. hexString .. " should produce a saturation of " .. tostring(saturation))
        assert(v == value, "Failed: " .. hexString .. " should produce a value of " .. tostring(value))
    end
end
