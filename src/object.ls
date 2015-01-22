'use strict'

curry = require './curry'

{ isType, isObject, isArray } = require './type'

# native methods
ObjHasOwnProperty = Object.prototype.hasOwnProperty

# empty :: object -> boolean
exports.empty = (obj) ->
    for k of obj then return false
    true

# has :: string -> object -> boolean
exports.has = curry (key, obj) ->
    ObjHasOwnProperty.call obj, key

# contains :: string -> object -> boolean
exports.contains = curry (elem, obj) ->
    for , v of obj when v is elem
        return true
    false

# keys :: object -> [string]
exports.keys = (obj) ->
    [k for k of obj]

# values :: object -> [any]
exports.values = (obj) ->
    [v for , v of obj]

# clone :: object -> object
exports.clone = (obj) ->
    exports.deepMixin void, obj

# each :: function -> object -> object
exports.each = curry (f, obj) ->
    for k, v of obj then (f v, k)
    obj

# map :: function -> object -> object
exports.map = curry (f, obj) ->
    {[k, (f v, k)] for k, v of obj}

# filter :: function -> object -> object
exports.filter = curry (f, obj) ->
    {[k, v] for k, v of obj when (f v, k)}

# every :: function -> object -> object
exports.every = curry (f, obj) ->
    for k, v of obj when (f v, k) is false
        return false
    true

# some :: function -> object -> object
exports.some = curry (f, obj) ->
    for k, v of obj when (f v, k) is true
        return true
    false

# partition :: function -> object -> [object]
exports.partition = curry (f, obj) ->
    passed = {}
    failed = {}
    for k, v of obj
        (if (f v, k) then passed else failed)[k] = v
    [passed, failed]

# keyOf :: any -> object -> string
exports.keyOf = curry (elem, obj) ->
    for k, v of obj
    when v is elem
        return k
    void

# keysOf :: any -> object -> string
exports.keysOf = curry (elem, obj) ->
    [k for k, v of obj when v is elem]

# findKey :: function -> object -> string
exports.findKey = curry (f, obj) ->
    for k, v of obj when (f v, k) then return k
    void

# findKeys :: function -> object -> [string]
exports.findKeys = curry (f, obj) ->
    [k for k, v of obj when (f v, k)]

# fromPairs :: array -> object
exports.fromPairs = (xs) ->
    {[x.0, x.1] for x in xs}

# toPairs :: object -> array
exports.toPairs = (obj) ->
    [[key, value] for key, value of obj]

# fill :: object -> ...object -> object
exports.fill = curry 1 (dest, ...sources) ->
    for src in sources
        for k of dest when src[k]?
            dest[k] = src[k]
    dest

# deepFill :: object -> ...object -> object
exports.deepFill = curry 1 (dest, ...sources) ->
    for src in sources then
        for key, value of dest when value?
            if (isObject src[key], value)
                dest[key] = exports.deepFill value, src[key]
            else
                dest[key] = src[key]
    dest

# mixin :: object -> ...object -> object
exports.mixin = curry 1 (dest = {}, ...sources) ->
    for src in sources then
        for key, val of src then
            dest[key] = val
    dest

# deepMixin :: object -> ...object -> object
exports.deepMixin = curry 1 (dest = {}, ...sources) ->
    for src in sources then
        for k, v of src then
            if (isObject dest[k]) and (isObject v)
            then dest[k] = exports.deepMixin dest[k], v
            else dest[k] = v
    dest

# freeze :: object -> object
exports.freeze = (obj) ->
    Object.freeze obj

# deepFreeze :: object -> object
exports.deepFreeze = (obj) ->
    Object.freeze obj unless Object.isFrozen obj
    for key, value of obj
    when (ObjHasOwnProperty.call obj, key) and (isObject value)
        exports.deepFreeze value
    obj

# toJSON :: object -> string
exports.toJSON = (obj) -> JSON.stringify obj, void, 2

# fromJSON :: string -> object
exports.fromJSON = (obj) -> JSON.parse obj

# definePublic :: object -> string|object -> maybe any -> object
exports.definePublic = curry (obj, key, value) ->
    if isObject key
        for k, v of key => exports.definePublic obj, k, v
        obj
    else
        Object.defineProperty obj, key, {
            value, +enumerable, +writable, +configurable
        }

# definePrivate :: object -> string|object -> maybe any -> object
exports.definePrivate = curry (obj, key, value) ->
    if isObject key
        for k, v of key => exports.definePrivate obj, k, v
        obj
    else
        Object.defineProperty obj, key, {
            value, -enumerable, +writable, +configurable
        }

# defineStatic :: object -> string|object -> maybe any -> object
exports.defineStatic = curry (obj, key, value) ->
    if isObject key
        for k, v of key => exports.defineStatic obj, k, v
        obj
    else
        Object.defineProperty obj, key, {
            value, +enumerable, -writable, +configurable
        }

# defineMeta :: object -> string|object -> maybe any -> object
exports.defineMeta = curry (obj, key, value) ->
    if isObject key
        for k, v of key => exports.defineMeta obj, k, v
        obj
    else
        Object.defineProperty obj, key, {
            value, -enumerable, -writable, +configurable
        }
