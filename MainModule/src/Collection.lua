--------------------------------------------------------------------------------------------------------------------------------
--[[                                             Copyright (C) Inertia Lighting                                             ]]--
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
--- @example
--- ```lua
--- local collection = Collection.new({ { 'hello', 'world' }, { 'lorem', 'ipsum' } })
--- print(collection:size()) -- 2
--- ```
function Collection:size()
    return #self._storage
end

--- @return table keys
--- @example
--- ```lua
--- local collection = Collection.new({ { 'this', 'is' }, { 'a', 'test' }, { 'collection', 'of' }, { 'keys', 'and' }, { 'values', '!' } })
--- print(collection:keys()) -- { 'this', 'a', 'collection', 'keys', 'values' }
--- ```
function Collection:keys()
    local keys = {}

    for _, entry in ipairs(self._storage) do
        table.insert(keys, entry[1])
    end

    return keys
end

--- @return table values
--- @example
--- ```lua
--- local collection = Collection.new({ { 'this', 'is' }, { 'a', 'test' }, { 'collection', 'of' }, { 'keys', 'and' }, { 'values', '!' } })
--- print(collection:values()) -- { 'is', 'test', 'of', 'and', '!' }
--- ```
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
--- @example
--- ```lua
--- local collection = Collection.new({ { 'iron', 'FE' }, { 'gold', 'AU' } })
--- print(collection:has('iron')) -- true
--- print(collection:has('platinum')) -- false
--- ```
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
--- @example
--- ```lua
--- local collection = Collection.new({ { 'apple', 'red' }, { 'banana', 'yellow' }, { 'blueberry', 'blue' } })
--- print(collection:get('apple')) -- red
--- print(collection:get('banana')) -- yellow
--- print(collection:get('blueberry')) -- blue
--- print(collection:get('orange')) -- nil
--- ```
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
--- print(collection:get('nice')) -- nil
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

--- Ensures that the collection has a value for the specified key.
--- @param key string
--- @param defaultValueGenerator function `(key, collection) => defaultValue`
--- @return any value
--- @example
--- ```lua
--- local collection = Collection.new()
--- collection:ensure('nice', function(key, collection)
---     return 69
--- end)
--- print(collection:get('nice')) -- 69
--- ```
function Collection:ensure(key, defaultValueGenerator)
    if type(key) ~= 'string' then
        error('Collection.ensure(): `key` must be a string')
    end

    if type(defaultValueGenerator) ~= 'function' then
        error('Collection.ensure(): `defaultValueGenerator` must be a function')
    end

    if self:has(key) then
        return self:get(key)
    end

    local defaultValue = defaultValueGenerator(key, self)
    self:set(key, defaultValue)
    return defaultValue
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

--- @param callback function `(value, key, tbl) => void`
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

--- @param mapFunction function `(value, key, collection) => newValue`
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

--- @param reduceFunction function `(accumulator, value, key, collection) => modifiedAccumulator`
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

--- @param compareFunction function `(firstValue, secondValue, firstKey, secondKey, collection) => boolean`
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

--- @param callback function `(value, key, collection) => any`
--- @return any value
--- @example
--- ```lua
--- local collection = Collection.new({
---     { '13123123', { name = 'John', age = 23 } },
---     { '12312312', { name = 'Jane', age = 21 } },
---     { '12312312', { name = 'Jack', age = 25 } },
--- })
--- local personNamedJohn = collection:find(function(value)
---     return value.name == 'John'
--- end)
--- print(personNamedJohn.age) -- 23
--- ```
function Collection:find(callback)
    if type(callback) ~= 'function' then
        error('Collection.find(): `callback` must be a function')
    end

    for _, entry in ipairs(self._storage) do
        if callback(entry[2], entry[1], self) then
            return entry[2]
        end
    end

    return nil
end

--- @param callback function `(value, key, collection) => new Collection`
--- @return table filtered collection contains the results of the filter function
--- @example
--- ```lua
--- local collection = Collection.new({ { 'nice', 69 }, { 'thing', 420 } })
--- local filtered = collection:filter(function(value)
---     return value > 100
--- end)
--- print(filtered) -- { { 'thing', 420 } }
--- ```
function Collection:filter(callback)
    if type(callback) ~= 'function' then
        error('Collection.filter(): `callback` must be a function')
    end

    local filtered = Collection.new()

    for _, entry in ipairs(self._storage) do
        if callback(entry[2], entry[1], self) then
            filtered:set(entry[1], entry[2])
        end
    end

    return filtered
end

--- @param collection table
--- @return table concatenatedCollection
--- @example
--- ```lua
--- local collection = Collection.new({ { 'nice', 69 }, { 'thing', 420 } })
--- local otherCollection = Collection.new({ { 'hello', 'world' }, { 'goodbye', 'moon' } })
--- local concatenatedCollection = collection:concat(otherCollection)
--- print(concatenatedCollection:size()) -- 4
--- ```
function Collection:concat(collection)
    if type(collection) ~= 'table' then
        error('Collection.concat(): `collection` must be a table')
    end

    local concatenatedCollection = Collection.new()

    for _, entry in ipairs(self._storage) do
        concatenatedCollection:set(entry[1], entry[2])
    end

    for _, entry in ipairs(collection) do
        concatenatedCollection:set(entry[1], entry[2])
    end

    return concatenatedCollection
end

--------------------------------------------------------------------------------------------------------------------------------

return Collection
