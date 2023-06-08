--------------------------------------------------------------------------------------------------------------------------------
--[[                                             Copyright (C) Inertia Lighting                                             ]] --
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Calling this script will run various tests to ensure that this library is working properly
--------------------------------------------------------------------------------------------------------------------------------

local testsFolder = script.Parent
local rootFolder = testsFolder.Parent

local LA = require(rootFolder.MainModule)

local testsWereSuccessful =
    pcall(
    function()
        --------------------------------------------------------------------------------------------------------------------------------
        -- Testing LA.String
        --------------------------------------------------------------------------------------------------------------------------------

        print("Testing LA.String")

        local testStr = " test "
        local testStrSplit = ",a,b,c,test,,1,,2,,3,"

        print("Testing LA.String.replicate")
        assert(LA.String.replicate(testStr, 0) == " test ", "Failed to replicate string 0 times")
        assert(LA.String.replicate(testStr, 1) == " test  test ", "Failed to replicate string 1 times")
        assert(LA.String.replicate(testStr, 2) == " test  test  test ", "Failed to replicate string 2 times")

        print("Testing LA.String.reverse")
        assert(LA.String.reverse(testStr) == " tset ", "Failed to reverse string")

        print("Testing LA.String.trim")
        assert(LA.String.trim(testStr) == "test", "Failed to trim string")

        print("Testing LA.String.charAt")
        assert(LA.String.charAt(testStr, -3) == "s", "Failed to retrieve char from index -3 in string")
        assert(LA.String.charAt(testStr, -2) == "t", "Failed to retrieve char from index -2 in string")
        assert(LA.String.charAt(testStr, -1) == " ", "Failed to retrieve char from index -1 in string")
        assert(LA.String.charAt(testStr, 0) == "", "Failed to retrieve char from index 0 in string")
        assert(LA.String.charAt(testStr, 1) == " ", "Failed to retrieve char from index 1 in string")
        assert(LA.String.charAt(testStr, 2) == "t", "Failed to retrieve char from index 2 in string")
        assert(LA.String.charAt(testStr, 3) == "e", "Failed to retrieve char from index 3 in string")

        print("Testing LA.String.charCodeAt")
        assert(LA.String.charCodeAt(testStr, -3) == 115, "Failed to retrieve char code from index -3 in string")
        assert(LA.String.charCodeAt(testStr, -2) == 116, "Failed to retrieve char code from index -2 in string")
        assert(LA.String.charCodeAt(testStr, -1) == 32, "Failed to retrieve char code from index -1 in string")
        assert(LA.String.charCodeAt(testStr, 0) == nil, "Failed to retrieve char code from index 0 in string")
        assert(LA.String.charCodeAt(testStr, 1) == 32, "Failed to retrieve char code from index 1 in string")
        assert(LA.String.charCodeAt(testStr, 2) == 116, "Failed to retrieve char code from index 2 in string")
        assert(LA.String.charCodeAt(testStr, 3) == 101, "Failed to retrieve char code from index 3 in string")

        print("Testing LA.String.split")
        local referenceSplitTestStr = {"", "a", "b", "c", "test", "", "1", "", "2", "", "3", ""}
        for i, v in ipairs(LA.String.split(testStrSplit, ",")) do
            assert(v == referenceSplitTestStr[i],"Failed to properly split string, test failed at index: " .. tostring(i))
        end

        print("Tests passed for LA.String")

        --------------------------------------------------------------------------------------------------------------------------------
        -- Testing LA.Table
        --------------------------------------------------------------------------------------------------------------------------------

        print("Testing LA.Table")

        local testTbl = {"a", "b", "c", "", "hello", "world", "", 1, 2, 3}
        local testTblMap = {1, 2, 3}
        local testTblReduce = {5, 10, 50}
        local testTblForEach = {5, 2, -1}

        print("Testing LA.Table.clone")
        for i, v in ipairs(LA.Table.clone(testTbl)) do
            assert(v == testTbl[i], "Failed to clone table, test failed at index: " .. tostring(i))
        end

        print("Testing LA.Table.join")
        assert(LA.Table.join(testTbl, ",") == "a,b,c,,hello,world,,1,2,3", "Failed to join table using commas")

        print("Testing LA.Table.slice")
        local referenceSlicedTestTbl = {"c", "", "hello", "world"}
        for i, v in ipairs(LA.Table.slice(testTbl, -8, 6)) do
            assert(v == referenceSlicedTestTbl[i], "Failed to slice table, test failed at index: " .. tostring(i))
        end

        print("Testing LA.Table.map")
        local referenceMultipliedTestTblMap = {2, 4, 6}
        local testTblMapMultipliedByTwo = LA.Table.map(
            testTblMap,
            function(value)
                return value * 2
            end
        )
        for i, v in ipairs(testTblMapMultipliedByTwo) do
            assert(v == referenceMultipliedTestTblMap[i], "Failed to map table, test failed at index: " .. tostring(i))
        end

        print("Testing LA.Table.reduce")
        local referenceSumOfTestTblReduce = 65
        local testTblReduceSum = LA.Table.reduce(
            testTblReduce,
            function(accumulatedValue, currentValue)
                return accumulatedValue + currentValue
            end
        )
        assert(testTblReduceSum == referenceSumOfTestTblReduce, "Failed to reduce table to sum of values")

        print("Testing LA.Table.forEach")
        local referenceTestTblForEach = -10
        local testTblForEachAccumulatedValue = 1
        LA.Table.forEach(
            testTblForEach,
            function(value)
                testTblForEachAccumulatedValue = testTblForEachAccumulatedValue * value
            end
        )
        assert(testTblForEachAccumulatedValue == referenceTestTblForEach,"Failed to forEach table to product of values")

        print("Testing LA.Table.includes")
        local referenceTestTblIncludesOne = "a"
        local referenceTestTblIncludesTwo = "z"
        local testTblIncludesOne = LA.Table.includes(testTbl, referenceTestTblIncludesOne)
        local testTblIncludesTwo = LA.Table.includes(testTbl, referenceTestTblIncludesTwo)
        assert(testTblIncludesOne and not testTblIncludesTwo, "Failed table includes test")

        print("Testing LA.Table.find")
        local referenceTestTblFindValue = "world"
        local testTblFindValue = LA.Table.find(
            testTbl,
            function(value)
                return value == referenceTestTblFindValue
            end
        )
        assert(testTblFindValue, "Failed to find value in table")

        -- @TODO Table.filter
        -- @TODO Table.reverse
        -- @TODO Table.prepend
        -- @TODO Table.append

        print("Tests passed for LA.Table")

        --------------------------------------------------------------------------------------------------------------------------------
        -- Testing LA.Utility
        --------------------------------------------------------------------------------------------------------------------------------

        print("Testing LA.Utility.switch")
        local referenceSwitchReturnValue = "y"
        local testSwitchReturnValue = LA.Utility.switch(
            "test_2",
            {
                ["test_1"] = function()
                    return "x"
                end,
                ["test_2"] = function()
                    return "y"
                end,
                ["test_3"] = function()
                    return "z"
                end,
                ["default"] = function()
                    return "default"
                end
            },
            true
        )
        assert(testSwitchReturnValue == referenceSwitchReturnValue,"Failed to return proper value from switch function")

        print("Testing LA.Utility.CreateInstance")
        local TestInstance = LA.Utility.CreateInstance("Folder", "TestFolder", true)
        assert(TestInstance ~= nil, "Failed to return new instance from CreateInstance function")

        print("Tests passed for LA.Utility")

        --------------------------------------------------------------------------------------------------------------------------------
        -- Testing Integer module
        --------------------------------------------------------------------------------------------------------------------------------

        print("Testing LA.Integer.isOdd")
        local number1IsOdd = LA.Integer.isOdd(5)
        assert(number1IsOdd == true, "Failed: 5 is an odd number")

        local number2IsOdd = LA.Integer.isOdd(10)
        assert(number2IsOdd == false, "Failed: 10 is not an odd number")

        print("Testing LA.Integer.isEven")
        local number1IsEven = LA.Integer.isEven(5)
        assert(number1IsEven == false, "Failed: 5 is not an even number")

        local number2IsEven = LA.Integer.isEven(10)
        assert(number2IsEven == true, "Failed: 10 is an even number")

        print("Testing LA.Integer.calculateHalf")
        local half1, half2 = LA.Integer.calculateHalf(7)
        assert(half1 == 3 and half2 == 4, "Failed: Incorrect halves for 7")

        local half3, half4 = LA.Integer.calculateHalf(10)
        assert(half3 == 10 and half4 == 10, "Failed: Incorrect halves for 10")

        print("Testing LA.Integer.absoluteValue")
        local absoluteValue1 = LA.Integer.absoluteValue(-5)
        assert(absoluteValue1 == 5, "Failed: Incorrect absolute value for -5")

        local absoluteValue2 = LA.Integer.absoluteValue(10)
        assert(absoluteValue2 == 10, "Failed: Incorrect absolute value for 10")

        print("Testing LA.Integer.maximum")
        local maximum1 = LA.Integer.maximum(5, 10)
        assert(maximum1 == 10, "Failed: Incorrect maximum value between 5 and 10")

        local maximum2 = LA.Integer.maximum(-3, -7)
        assert(maximum2 == -3, "Failed: Incorrect maximum value between -3 and -7")

        print("Testing LA.Integer.minimum")
        local minimum1 = LA.Integer.minimum(5, 10)
        assert(minimum1 == 5, "Failed: Incorrect minimum value between 5 and 10")

        local minimum2 = LA.Integer.minimum(-3, -7)
        assert(minimum2 == -7, "Failed: Incorrect minimum value between -3 and -7")

        print("Testing LA.Integer.round")
        local rounded1 = LA.Integer.round(5.3)
        assert(rounded1 == 5, "Failed: Incorrect rounded value for 5.3")

        local rounded2 = LA.Integer.round(9.8)
        assert(rounded2 == 10, "Failed: Incorrect rounded value for 9.8")

        print("Testing LA.Integer.power")
        local power1 = LA.Integer.power(2, 3)
        assert(power1 == 8, "Failed: Incorrect power value for 2^3")

        local power2 = LA.Integer.power(5, 0)
        assert(power2 == 1, "Failed: Incorrect power value for 5^0")

        print("Testing LA.Integer.squareRoot")
        local squareRoot1 = LA.Integer.squareRoot(16)
        assert(squareRoot1 == 4, "Failed: Incorrect square root value for 16")

        local squareRoot2 = LA.Integer.squareRoot(25)
        assert(squareRoot2 == 5, "Failed: Incorrect square root value for 25")

        print("Testing LA.Integer.sine")
        local sine1 = LA.Integer.sine(0)
        assert(sine1 == 0, "Failed: Incorrect sine value for 0")

        local sine2 = LA.Integer.sine(math.pi / 2)
        assert(sine2 == 1, "Failed: Incorrect sine value for pi/2")

        print("Testing LA.Integer.cosine")
        local cosine1 = LA.Integer.cosine(0)
        assert(cosine1 == 1, "Failed: Incorrect cosine value for 0")

        local cosine2 = LA.Integer.cosine(math.pi)
        assert(cosine2 == -1, "Failed: Incorrect cosine value for pi")

        print("Testing LA.Integer.tangent")
        local tangent1 = LA.Integer.tangent(0)
        assert(tangent1 == 0, "Failed: Incorrect tangent value for 0")

        local tangent2 = LA.Integer.tangent(math.pi / 4)
        assert(tangent2 == 1, "Failed: Incorrect tangent value for pi/4")

        print("Testing LA.Integer.randomInRange")
        local random1 = LA.Integer.randomInRange(1, 10)
        assert(random1 >= 1 and random1 <= 10, "Failed: Random value not within the specified range")

        local random2 = LA.Integer.randomInRange(-5, 5)
        assert(random2 >= -5 and random2 <= 5, "Failed: Random value not within the specified range")

        print("Tests passed for LA.Integer")

        --------------------------------------------------------------------------------------------------------------------------------
        -- Testing Color
        --------------------------------------------------------------------------------------------------------------------------------

        print("Testing Color")

        local red, green, blue = 255, 0, 0
        local hue, saturation, value = 0, 1, 1
        local htmlColorCode = "#FF0000"

        print("Testing Color.rgbToHsv")
        local calculatedHue, calculatedSaturation, calculatedValue = LA.Color.rgbToHsv(red, green, blue)
        assert(calculatedHue == hue, "Failed to convert RGB to HSV - incorrect hue value")
        assert(calculatedSaturation == saturation, "Failed to convert RGB to HSV - incorrect saturation value")
        assert(calculatedValue == value, "Failed to convert RGB to HSV - incorrect value value")

        print("Testing Color.rgbToHtml")
        local calculatedHtmlColorCode = LA.Color.rgbToHtml(red, green, blue)
        assert(calculatedHtmlColorCode == htmlColorCode, "Failed to convert RGB to HTML color code")

        print("Testing Color.hsvToRgb")
        local calculatedRed, calculatedGreen, calculatedBlue = LA.Color.hsvToRgb(hue, saturation, value)
        assert(calculatedRed == red, "Failed to convert HSV to RGB - incorrect red value")
        assert(calculatedGreen == green, "Failed to convert HSV to RGB - incorrect green value")
        assert(calculatedBlue == blue, "Failed to convert HSV to RGB - incorrect blue value")

        print("Testing Color.hsvToHtml")
        local calculatedHtmlColorCode = LA.Color.hsvToHtml(hue, saturation, value)
        assert(calculatedHtmlColorCode == htmlColorCode, "Failed to convert HSV to HTML color code")

        print("Testing Color.htmlToRgb")
        local calculatedRed, calculatedGreen, calculatedBlue = LA.Color.htmlToRgb(htmlColorCode)
        assert(calculatedRed == red, "Failed to convert HTML color code to RGB - incorrect red value")
        assert(calculatedGreen == green, "Failed to convert HTML color code to RGB - incorrect green value")
        assert(calculatedBlue == blue, "Failed to convert HTML color code to RGB - incorrect blue value")

        print("Testing Color.htmlToHsv")
        local calculatedHue, calculatedSaturation, calculatedValue = LA.Color.htmlToHsv(htmlColorCode)
        assert(calculatedHue == hue, "Failed to convert HTML color code to HSV - incorrect hue value")
        assert(calculatedSaturation == saturation,"Failed to convert HTML color code to HSV - incorrect saturation value")
        assert(calculatedValue == value, "Failed to convert HTML color code to HSV - incorrect value value")

        print("Tests passed for Color")
end)

return testsWereSuccessful -- true | false