# Lua Additions

## About

### Lua Additions aims to provide enhancements for Roblox and Lua's standard library.

### A large portion of this library is inspired by the TC39 ECMAScript (JavaScript) standard.

## Installation (Roblox)

- ### Automatic
    ```lua
    -- The following asset id is owned and updated by Inertia Lighting.
    -- Inertia Lighting expresses no guarantee or liability for the usage of this asset id.
    local LA = require(7564836781)
    ```

- ### Manual (used for testing)
    1. Download the latest release from the [releases](https://github.com/Inertia-Lighting/lua-additions/releases) page.
    2. Insert the `lua-additions[...].rbxm` file into the `Workspace` folder in Roblox Studio.
    3. Ensure that the `lua-additions` folder was inserted into the `Workspace` folder.
    ```lua
    local LA = require(game.Workspace:WaitForChild('lua-additions'):WaitForChild('MainModule'))
    ```

- ### Check the installation
    Ensure the version of Lua Additions you are using is up-to-date with the [latest release](https://github.com/Inertia-Lighting/lua-additions/releases).
    ```lua
    print(LA.version)
    ```

## Example Usage

The following contains two examples of what you can accomplish with Lua Additions.  
Check with the [source code](./src) for documentation and a comprehensive listing of the methods and utilities that are available.
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

----------------------------------------------------------------

LA.Utility.try(function()
    -- this will throw an error
    error('the developer ran out of coffee')
end):catch(function(errorMessage)
    -- the error will be caught and sent here
    warn('something went wrong!', errorMessage)
end)
print('this isn\'t affected by the error above')

-- Output:
-- something went wrong! the developer ran out of coffee
-- this isn't affected by the error above
```

## Testing (Roblox)

To test this library, you must require the tests module from the **manual installation** above.
```lua
-- some script
local luaAdditionsFolder = game.Workspace:WaitForChild('lua-additions')
local luaAdditionsTestsFolder = luaAdditionsFolder:WaitForChild('tests')
local luaAdditionsTestsFolderScript = luaAdditionsTestsFolder:WaitForChild('tests')
local luaAdditionsTestsWereSuccessful = require(luaAdditionsTestsFolderScript)

print('luaAdditionsTestsWereSuccessful:', luaAdditionsTestsWereSuccessful)

-- luaAdditionsTestsWereSuccessful: true
```
Any errors will be shown in the console.  
Any PRs that improve the test coverage of the library will be appreciated.

## Development

To assist with developing this library, you can use [Rojo](https://rojo.space/) to easily work in your code editor of choice and have it automatically sync to Roblox Studio.
```
rojo serve
```

## License

### This repository uses the MIT license.

### You can read the license [here](./LICENSE.md).

## Copyright

Copyright &copy; Inertia Lighting | Some Rights Reserved
