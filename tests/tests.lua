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

    assert(LA.String.replicate(testStr, 0) == ' test ', 'Failed to replicate string 0 times')
    assert(LA.String.replicate(testStr, 1) == ' test  test ', 'Failed to replicate string 1 times')
    assert(LA.String.replicate(testStr, 2) == ' test  test  test ', 'Failed to replicate string 2 times')

    assert(LA.String.reverse(testStr) == ' tset ', 'Failed to reverse string')

    assert(LA.String.trim(testStr) == 'test', 'Failed to trim string')

    assert(LA.String.charAt(testStr, -3) == 's', 'Failed to retrieve char from index -3 in string')
    assert(LA.String.charAt(testStr, -2) == 't', 'Failed to retrieve char from index -2 in string')
    assert(LA.String.charAt(testStr, -1) == ' ', 'Failed to retrieve char from index -1 in string')
    assert(LA.String.charAt(testStr, 0) == '', 'Failed to retrieve char from index 0 in string')
    assert(LA.String.charAt(testStr, 1) == ' ', 'Failed to retrieve char from index 1 in string')
    assert(LA.String.charAt(testStr, 2) == 't', 'Failed to retrieve char from index 2 in string')
    assert(LA.String.charAt(testStr, 3) == 'e', 'Failed to retrieve char from index 3 in string')

    assert(LA.String.charCodeAt(testStr, -3) == 115, 'Failed to retrieve char code from index -3 in string')
    assert(LA.String.charCodeAt(testStr, -2) == 116, 'Failed to retrieve char code from index -2 in string')
    assert(LA.String.charCodeAt(testStr, -1) == 32, 'Failed to retrieve char code from index -1 in string')
    assert(LA.String.charCodeAt(testStr, 0) == nil, 'Failed to retrieve char code from index 0 in string')
    assert(LA.String.charCodeAt(testStr, 1) == 32, 'Failed to retrieve char code from index 1 in string')
    assert(LA.String.charCodeAt(testStr, 2) == 116, 'Failed to retrieve char code from index 2 in string')
    assert(LA.String.charCodeAt(testStr, 3) == 101, 'Failed to retrieve char code from index 3 in string')

    local referenceSplitTestStr = { "", "a", "b", "c", "test", "", "1", "", "2", "", "3", "" }
    for i, v in ipairs(LA.String.split(testStrSplit, ',')) do
        assert(v == referenceSplitTestStr[i], 'Failed to properly split string, test failed at index: ' .. tostring(i))
    end

    print('Tests passed for LA.String')

    --------------------------------------------------------------------------------------------------------------------------------
    -- Testing LA.Table
    --------------------------------------------------------------------------------------------------------------------------------

    -- @TODO
end)

return testsWereSuccessful -- true | false
