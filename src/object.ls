'use strict'

{ isType } = require './prelude'
{ curry }  = require './func'

# empty :: object -> boolean
export empty = (obj) ->
    for x of object then return false
    true

# clone :: object -> object
export clone = (obj) ->
    deepMixin null, obj

# keys :: object -> [string]
export keys = (obj) ->
    [k for k of obj]

# values :: object -> [any]
export values = (obj) ->
    [x for , x of obj]

# each :: function -> object -> object
export each = curry (f, obj) ->
    for k, v of obj then f v, k
    obj

# map :: function -> object -> object
export map = curry (f, obj) ->
    {[k, f x] for k, x of obj}

# filter :: function -> object -> object
export filter = curry (f, object) ->
    {[k, v] for k, v of object when f v, k}

# partition :: function -> object -> [object]
export partition = curry (f, object) ->
    passed = {}
    failed = {}
    for k, v of object
        (if f v, k then passed else failed)[k] = v
    [passed, failed]

# mixin :: object -> ...object -> object
export mixin = (dest = {}, ...sources) ->
    for src in sources then
        for key, val of src then
            dest[key] = val
    dest

# mixin :: object -> ...object -> object
export deepMixin = (dest = {}, ...sources) ->
    for src in sources then
        for key, val of src then
            if (isType 'Object' dest[key]) and (isType 'Object' src[key])
            then dest[key] = deepMixin dest[key], src[key]
            else dest[key] = val
    dest

# keyOf :: any -> object -> string
export keyOf = curry (elem, obj) ->
    for k, v of obj
    when v is elem
        return k
    void

# keysOf :: any -> object -> string
export keysOf = curry (elem, obj) ->
    [k for k, v in obj when v is elem]

# findKey :: function -> object -> string
export findKey = curry (f, obj) ->
    for k, v of obj when f v, k
        return k
    void

# findKeys :: function -> object -> [string]
export findKeys = curry (f, obj) ->
    [k for k, v in obj when f v, k]

# fromPairs :: array -> object
export fromPairs = (xs) ->
    {[x.0, x.1] for x in xs}

# toPairs :: object -> array
export toPairs = (obj) ->
    [[key, value] for key, value of obj]
