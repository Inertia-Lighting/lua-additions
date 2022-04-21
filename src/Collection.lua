--------------------------------------------------------------------------------------------------------------------------------
--[[                                              Copyright © Inertia Lighting                                              ]]--
--------------------------------------------------------------------------------------------------------------------------------

local Collection = {}
Collection.__index = Collection

--------------------------------------------------------------------------------------------------------------------------------

--- @param entries table
--- @return table (new collection)
--- @example
--- ```lua
--- local collection = Collection.new({ { 'nice', 69 }, { 'thing', 420 } })
--- print(collection:size()) -- 2
--- print(collection:get('nice')) -- 69
--- ```
function Collection.new(entries)
    if (entries ~= nil) and (type(entries) ~= 'table') then
        error('Collection.new(): `entries` must be a table when specified')
    end

    local self = setmetatable({}, Collection)

    self.size = function()
        return #self._storage
    end

    self._storage = {} -- { [number]: { [key: string], [value: any] } }

    if entries then
        for _, entry in ipairs(entries) do
            self:set(entry[1], entry[2])
        end
    end

    return self
end

--------------------------------------------------------------------------------------------------------------------------------

--- @return number
function Collection:size()
    return #self._storage
end

--- @return table keys
function Collection:keys()
    local keys = {}

    for _, entry in ipairs(self._storage) do
        table.insert(keys, entry[1])
    end

    return keys
end

--- @return table values
function Collection:values()
    local values = {}

    for _, entry in ipairs(self._storage) do
        table.insert(values, entry[2])
    end

    return values
end

--------------------------------------------------------------------------------------------------------------------------------

--- @param key string
--- @return boolean exists
function Collection:has(key)
    if type(key) ~= 'string' then
        error('Collection.has(): `key` must be a string')
    end

    for _, entry in ipairs(self._storage) do
        if entry[1] == key then
            return true
        end
    end

    return false
end

--- @param key string
--- @return any value (defaults to `nil` if not found)
function Collection:get(key)
    if type(key) ~= 'string' then
        error('Collection.get(): `key` must be a string')
    end

    for _, entry in ipairs(self._storage) do
        if entry[1] == key then
            return entry[2]
        end
    end

    return nil
end

--- @param key string
--- @param value any
--- @return table self
--- @example
--- ```lua
--- local collection = Collection.new()
--- collection:set('nice', 69)
--- print(collection:get('nice')) -- 69
--- ```
function Collection:set(key, value)
    if type(key) ~= 'string' then
        error('Collection.set(): `key` must be a string')
    end

    for index, entry in ipairs(self._storage) do
        if entry[1] == key then
            self._storage[index] = { key, value }

            return self
        end
    end

    table.insert(self._storage, { key, value })

    return self
end

--- @param key string
--- @return boolean deleted if the key was found and removed
--- @example
--- ```lua
--- local collection = Collection.new({ { 'nice', 69 }, { 'thing', 420 } })
--- print(collection:size()) -- 2
--- print(collection:delete('nice')) -- true
--- print(collection:size()) -- 1
--- print(collection:delete('nice')) -- false
--- ```
function Collection:delete(key)
    if type(key) ~= 'string' then
        error('Collection.delete(): `key` must be a string')
    end

    for index, entry in ipairs(self._storage) do
        if entry[1] == key then
            table.remove(self._storage, index)

            return true
        end
    end

    return false
end

--- @return table self
--- @example
--- ```lua
--- local collection = Collection.new({ { 'nice', 69 }, { 'thing', 420 } })
--- print(collection:size()) -- 2
--- collection:clear() -- Collection
--- print(collection:size()) -- 0
function Collection:clear()
    self._storage = {}

    return self
end

--- @param callback function callback(value, key, tbl)
--- @return table self
--- @example
--- ```lua
--- local collection = Collection.new({ { 'nice', 69 }, { 'thing', 420 } })
--- collection:forEach(function(value, key, tbl)
---     print(key, value)
--- end)
--- -- nice 69
--- -- thing 420
--- ```
function Collection:forEach(callback)
    if type(callback) ~= 'function' then
        error('Collection.forEach(): `callback` must be a function')
    end

    for _, entry in ipairs(self._storage) do
        callback(entry[2], entry[1], self)
    end

    return self
end

--- @param mapFunction function `cb(value, key, collection)`
--- @return table mapped contains the results of the map function
--- @example
--- ```lua
--- local collection = Collection.new({ { 'd1', '231' }, { 'd2', '123' }, { 'd3', '456' } })
--- local mapped = collection:map(function(value)
---     return string.format('%s: %s', 'data-sample-', value)
--- end)
--- print(mapped) -- { 'data-sample-231', 'data-sample-123', 'data-sample-456' }
--- ```
function Collection:map(mapFunction)
    if type(mapFunction) ~= 'function' then
        error('Collection.map(): `mapFunction` must be a function')
    end

    local mapped = {}

    for _, entry in ipairs(self._storage) do
        table.insert(mapped, mapFunction(entry[2], entry[1], self))
    end

    return mapped
end

--- @param reduceFunction function `cb(accumulator, value, key, collection)`
--- @param initialValue any (optional, defaults to `nil`)
--- @example
--- ```lua
--- local collection = Collection.new({ { 'nice', 69 }, { 'thing', 420 } })
--- local sum = collection:reduce(function(accumulator, value)
---     return accumulator + value
--- end, 0)
--- print(sum) -- 489
--- ```
function Collection:reduce(reduceFunction, initialValue)
    if type(reduceFunction) ~= 'function' then
        error('Collection.reduce(): `reduceFunction` must be a function')
    end

    local accumulator = initialValue or nil

    for _, entry in ipairs(self._storage) do
        accumulator = (accumulator == nil) and entry[2] or reduceFunction(accumulator, entry[2], entry[1], self)
    end

    return accumulator
end

--- @param compareFunction function `cb(firstValue, secondValue, firstKey, secondKey, collection)`
--- @example
--- ```lua
--- local collection = Collection.new({ { 'a', 4 }, { 'b', 2 }, { 'c', 5 }, { 'd', 1 }, { 'e', 3 } })
--- collection:sort(function(firstValue, secondValue)
---     return firstValue < secondValue
--- end)
--- ```
function Collection:sort(compareFunction)
    if type(compareFunction) ~= 'function' then
        error('Collection.sort(): `compareFunction` must be a function')
    end

    table.sort(self._storage, function(a, b)
        return compareFunction(a[2], b[2], a[1], b[1], self)
    end)

    return self
end

--------------------------------------------------------------------------------------------------------------------------------

return Collection
