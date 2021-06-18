--------------------------------------------------------------------------------------------------------------------------------
--[[                                              Copyright © Inertia Lighting                                              ]]--
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Calling this script will run various tests to ensure that this library is working properly
--------------------------------------------------------------------------------------------------------------------------------

local testsFolder = script.Parent
local rootFolder = testsFolder.Parent

local LA = require(rootFolder.MainModule)

local testsWereSuccessful = spawn(function()
    --------------------------------------------------------------------------------------------------------------------------------
    -- Testing LA.String
    --------------------------------------------------------------------------------------------------------------------------------

    print('Testing LA.String')

    local testStr = ' test '
    local testStrSplit = ',a,b,c,test,,1,,2,,3,'

    print('Testing LA.String.replicate')
    assert(LA.String.replicate(testStr, 0) == ' test ', 'Failed to replicate string 0 times')
    assert(LA.String.replicate(testStr, 1) == ' test  test ', 'Failed to replicate string 1 times')
    assert(LA.String.replicate(testStr, 2) == ' test  test  test ', 'Failed to replicate string 2 times')

    print('Testing LA.String.reverse')
    assert(LA.String.reverse(testStr) == ' tset ', 'Failed to reverse string')

    print('Testing LA.String.trim')
    assert(LA.String.trim(testStr) == 'test', 'Failed to trim string')

    print('Testing LA.String.charAt')
    assert(LA.String.charAt(testStr, -3) == 's', 'Failed to retrieve char from index -3 in string')
    assert(LA.String.charAt(testStr, -2) == 't', 'Failed to retrieve char from index -2 in string')
    assert(LA.String.charAt(testStr, -1) == ' ', 'Failed to retrieve char from index -1 in string')
    assert(LA.String.charAt(testStr, 0) == '', 'Failed to retrieve char from index 0 in string')
    assert(LA.String.charAt(testStr, 1) == ' ', 'Failed to retrieve char from index 1 in string')
    assert(LA.String.charAt(testStr, 2) == 't', 'Failed to retrieve char from index 2 in string')
    assert(LA.String.charAt(testStr, 3) == 'e', 'Failed to retrieve char from index 3 in string')

    print('Testing LA.String.charCodeAt')
    assert(LA.String.charCodeAt(testStr, -3) == 115, 'Failed to retrieve char code from index -3 in string')
    assert(LA.String.charCodeAt(testStr, -2) == 116, 'Failed to retrieve char code from index -2 in string')
    assert(LA.String.charCodeAt(testStr, -1) == 32, 'Failed to retrieve char code from index -1 in string')
    assert(LA.String.charCodeAt(testStr, 0) == nil, 'Failed to retrieve char code from index 0 in string')
    assert(LA.String.charCodeAt(testStr, 1) == 32, 'Failed to retrieve char code from index 1 in string')
    assert(LA.String.charCodeAt(testStr, 2) == 116, 'Failed to retrieve char code from index 2 in string')
    assert(LA.String.charCodeAt(testStr, 3) == 101, 'Failed to retrieve char code from index 3 in string')

    print('Testing LA.String.split')
    local referenceSplitTestStr = { '', 'a', 'b', 'c', 'test', '', '1', '', '2', '', '3', '' }
    for i, v in ipairs(LA.String.split(testStrSplit, ',')) do
        assert(v == referenceSplitTestStr[i], 'Failed to properly split string, test failed at index: ' .. tostring(i))
    end

    print('Tests passed for LA.String')

    --------------------------------------------------------------------------------------------------------------------------------
    -- Testing LA.Table
    --------------------------------------------------------------------------------------------------------------------------------

    print('Testing LA.Table')

    local testTbl = { 'a', 'b', 'c', '', 'hello', 'world', '', 1, 2, 3 }
    local testTblMap = { 1, 2, 3 }
    local testTblReduce = { 5, 10, 50 }
    local testTblForEach = { 5, 2, -1 }

    print('Testing LA.Table.clone')
    for i, v in ipairs(LA.Table.clone(testTbl)) do
        assert(v == testTbl[i], 'Failed to clone table, test failed at index: ' .. tostring(i))
    end

    print('Testing LA.Table.join')
    assert(LA.Table.join(testTbl, ',') == 'a,b,c,,hello,world,,1,2,3', 'Failed to join table using commas')

    print('Testing LA.Table.slice')
    local referenceSlicedTestTbl = { 'c', '', 'hello' }
    for i, v in ipairs(LA.Table.slice(testTbl, 3, 6)) do
        assert(v == referenceSlicedTestTbl[i], 'Failed to slice table, test failed at index: ' .. tostring(i))
    end

    print('Testing LA.Table.map')
    local referenceMultipliedTestTblMap = { 2, 4, 6 }
    local testTblMapMultipliedByTwo = LA.Table.map(testTblMap, function(value) return value * 2 end)
    for i, v in ipairs(testTblMapMultipliedByTwo) do
        assert(v == referenceMultipliedTestTblMap[i], 'Failed to map table, test failed at index: ' .. tostring(i))
    end

    print('Testing LA.Table.reduce')
    local referenceSumOfTestTblReduce = 65
    local testTblReduceSum = LA.Table.reduce(testTblReduce, function(accumulatedValue, currentValue) return accumulatedValue + currentValue end)
    assert(testTblReduceSum == referenceSumOfTestTblReduce, 'Failed to reduce table to sum of values')

    print('Testing LA.Table.forEach')
    local referenceTestTblForEach = -10
    local testTblForEachAccumulatedValue = 1
    LA.Table.forEach(testTblForEach, function(value) testTblForEachAccumulatedValue = testTblForEachAccumulatedValue * value end)
    assert(testTblForEachAccumulatedValue == referenceTestTblForEach, 'Failed to forEach table to product of values')

    print('Testing LA.Table.includes')
    local referenceTestTblIncludesOne = 'a'
    local referenceTestTblIncludesTwo = 'z'
    local testTblIncludesOne = LA.Table.includes(testTbl, referenceTestTblIncludesOne)
    local testTblIncludesTwo = LA.Table.includes(testTbl, referenceTestTblIncludesTwo)
    assert(testTblIncludesOne and not testTblIncludesTwo, 'Failed table includes test')

    print('Testing LA.Table.find')
    local referenceTestTblFindValue = 'world'
    local testTblFindValue = LA.Table.find(testTbl, function(value) return value == referenceTestTblFindValue end)
    assert(testTblFindValue, 'Failed to find value in table')

    -- @TODO Table.filter
    -- @TODO Table.reverse
    -- @TODO Table.prepend
    -- @TODO Table.append

    print('Tests passed for LA.Table')
end)

return testsWereSuccessful -- true | false
