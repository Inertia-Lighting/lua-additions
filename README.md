# Lua Additions (beta | not safe for production usage)

## About

### This library aims to provide enhancements for Roblox and Lua's standard library.
### This library is ready to use (with little modifications) inside of Roblox.
### Most of the methods in this library are directly inspired by the TC39 ECMAScript (JavaScript) standard.

## Example Usage for Roblox
### Currently we have not released a require-able asset for this repository, therefore you must download this repository into your game, into a folder called `lua-additions`.
```lua
-- some script
local LA = require(game.Workspace:WaitForChild('lua-additions'):WaitForChild('MainModule'))

local mathProblems = {
    add = { 24, 3, 5, 7 },
    subtract = { 24, 3, 5, 7 },
}

local solvedMathProblems = LA.Table.map(mathProblems, function(mathProblemValues, mathProblemType)
    return LA.Table.reduce(mathProblemValues, function(accumulatorValue, currentValue)
        if mathProblemType == 'add' then
            return accumulatorValue + currentValue
        elseif mathProblemType == 'subtract' then
            return accumulatorValue - currentValue
        else
            warn('Encountered an unrecognized math problem type!')
        end
    end)
end)

print(solvedMathProblems)

-- solvedMathProblems = {
--     add = 39,
--     subtract = 9,
-- }
```

## License

### This repository uses the MIT license.
### Check out the [License](./LICENSE.md).
