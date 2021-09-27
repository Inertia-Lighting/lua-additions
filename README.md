# Lua Additions

## Warning
### This is a beta version of Lua Additions (use at your own risk).

## About
### Lua Additions aims to provide enhancements for Roblox and Lua's standard library.
### Most of the methods in this library are directly inspired by the TC39 ECMAScript (JavaScript) standard.

## Installation

- ### Automatic
    ```lua
    local LA = require(7564836781)
    ```

- ### Manual
    1. Download the latest release from the [releases](https://github.com/Inertia-Lighting/lua-additions/releases) page.
    2. Insert the `lua-additions[...].rbxm` file into the `Workspace` folder in Roblox Studio.
    3. Ensure that the `lua-additions` folder was inserted into the `Workspace` folder.
    ```lua
    local LA = require(game.Workspace:WaitForChild('lua-additions'):WaitForChild('MainModule'))
    ```
- ### Check the installation
    Make sure to check that the version of Lua Additions you are using is up-to-date.
    ```lua
    print(LA.version)
    ```

## Usage
```lua
-- import lua-additions from the installation step above

local mathProblems = {
    ['add'] = { 24, 3, 5, 7 }, -- goal: add all of the numbers
    ['subtract'] = { 24, 3, 5, 7 }, -- goal: subtract all of the numbers
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

print('Output:')
LA.Table.forEach(solvedMathProblems, function(solvedMathProblemValue, solvedMathProblemType)
    print(solvedMathProblemType, ':', solvedMathProblemValue)
end)

-- Output:
-- add : 39
-- subtract : 9
```

## Testing
To test this library, you must require the tests module.
```lua
-- some script
local luaAdditionsFolder = game.Workspace:WaitForChild('lua-additions')
local luaAdditionsTestsFolder = luaAdditionsFolder:WaitForChild('tests')
local luaAdditionsTestsFolderScript = luaAdditionsTestsFolder:WaitForChild('tests')
local luaAdditionsTestsWereSuccessful = require(luaAdditionsTestsFolderScript)

print('luaAdditionsTestsWereSuccessful:', luaAdditionsTestsWereSuccessful)

-- luaAdditionsTestsWereSuccessful: true
```
Any errors will be outputted to the console.

## Development
To assist with developing this library, you can use Rojo.
```
rojo serve
```

## License

### This repository uses the MIT license.
### You can read the license [here](./LICENSE.md).

## Copyright
Copyright &copy; Inertia Lighting | Some Rights Reserved
