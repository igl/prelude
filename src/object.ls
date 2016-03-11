'use strict'

curry = require './curry'
array = require './array'

{ isString, isObject, isArray } = require './type'

# native methods
ObjHasOwnProperty = Object.prototype.hasOwnProperty

# empty :: object -> boolean
exports.empty = (obj) ->
    for k of obj then return false
    true

# has :: string -> object -> boolean
exports.has = curry (key, obj) ->
    ObjHasOwnProperty.call obj, key

# includes :: string -> object -> boolean
exports.includes = curry (elem, obj) ->
    for , v of obj when v is elem
        return true
    false

exports.contains = exports.includes

# keys :: object -> [string]
exports.keys = (obj) ->
    [k for k of obj]

# values :: object -> [any]
exports.values = (obj) ->
    [v for , v of obj]

# clone :: object -> object
exports.clone = (obj) ->
    exports.deepMerge {}, obj

# flatten :: string? -> object -> object
exports.flatten = curry (delimiter, obj) ->
    result = {}

    obj |> !function parse (obj, parentKey = '')
        for key, child of obj
            if parentKey and isString delimiter
                key := "#parentKey#delimiter#key"

            if isObject child and (Object.keys child .length > 0)
                parse child, key
            else
                result[key] := child
    result

exports.explode = curry (delimiter, obj) ->
    result = {}

    obj |> !function parse (obj, parentKey = '')
        for flatKey, value of obj

            ref  = result
            keys = flatKey.split delimiter
            len  = keys.length - 1

            for k, i in keys
                if i < len
                    ref[k] = {} unless isObject ref[k]
                    ref := ref[k]
                    continue
                ref[k] = value
    result

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
exports.fill = curry 1 (init, ...sources) ->
    res = {}
    for src in sources
        for k of init when src[k]?
            res[k] = src[k]
    res

# deepFill :: object -> ...object -> object
exports.deepFill = curry 1 (init, ...sources) ->
    res = {}
    for src in sources
        for own key of init when src[key]?
            if isObject src[key] and isObject init[key]
                res[key] = exports.deepFill init[key], src[key]
            else
                res[key] = src[key]
    res

# merge :: object -> ...object -> object
exports.merge = curry 1 (...sources) ->
    dest = {}
    for src in sources
        for own key, val of src
            dest[key] = val
    dest

# deepMerge :: object -> ...object -> object
exports.deepMerge = curry 1 (...sources) ->
    dest = {}
    for src in sources then for key, value of src
        if isObject value and isObject dest[key]
            dest[key] = exports.deepMerge {}, dest[key], value

        else if isArray value
            dest[key] = array.clone value

        else
            dest[key] = value
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
exports.toJSON = (obj, indentBy = 0) ->
    JSON.stringify obj, void, indentBy

# FromJSON :: object -> (error, string) -> void
exports.fromJSON = (obj, fn) ->
    try res = JSON.parse obj
    catch err
    fn err, res if typeof fn is 'function'
    res

# fromJSONUnsafe :: string -> object
exports.fromJSONUnsafe = (obj) -> JSON.parse obj

# definePublic :: object -> string|object -> maybe any -> object
exports.definePublic = curry 1 (obj, key, value) ->
    if isObject key
        for k, v of key => exports.definePublic obj, k, v
        obj
    else
        Object.defineProperty obj, key, {
            value, +enumerable, +writable, +configurable
        }

# definePrivate :: object -> string|object -> maybe any -> object
exports.definePrivate = curry 1 (obj, key, value) ->
    if isObject key
        for k, v of key => exports.definePrivate obj, k, v
        obj
    else
        Object.defineProperty obj, key, {
            value, -enumerable, +writable, +configurable
        }

# defineStatic :: object -> string|object -> maybe any -> object
exports.defineStatic = curry 1 (obj, key, value) ->
    if isObject key
        for k, v of key => exports.defineStatic obj, k, v
        obj
    else
        Object.defineProperty obj, key, {
            value, +enumerable, -writable, +configurable
        }

# defineMeta :: object -> string|object -> maybe any -> object
exports.defineMeta = curry 1 (obj, key, value) ->
    if isObject key
        for k, v of key => exports.defineMeta obj, k, v
        obj
    else
        Object.defineProperty obj, key, {
            value, -enumerable, -writable, +configurable
        }
