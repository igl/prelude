'use strict'

# empty :: object -> boolean
export empty = (obj) ->
    for x of object then return false
    true

# keys :: object -> [string]
export keys = (obj) ->
    [k for k of obj]

# values :: object -> [any]
export values = (obj) ->
    [x for , x of obj]

# each :: function -> object -> object
export each = (f, obj) -->
    for k, v of obj then f v, k
    obj

# map :: function -> object -> object
export map = (f, obj) -->
    {[k, f x] for k, x of obj}

# filter :: function -> object -> object
export filter = (f, object) -->
    {[k, x] for k, x of object when f x}

# partition :: function -> object -> [object]
export partition = (f, object) -->
    passed = {}
    failed = {}
    for k, x of object
        (if f x then passed else failed)[k] = x
    [passed, failed]

# keyOf :: any -> object -> string
export keyOf = (elem, obj) -->
    for k, v of obj
    when v is elem
        return k
    void

# keysOf :: any -> object -> string
export keysOf = (elem, obj) -->
    [k for k, v in obj when v is elem]

# findKey :: function -> object -> string
export findKey = (f, obj) -->
    for k, v of obj when f v, k
        return k
    void

# findKeys :: function -> object -> [string]
export findKeys = (f, obj) -->
    [k for k, v in obj when f v, k]

# fromPairs :: array -> object
export fromPairs = (xs) ->
    {[x.0, x.1] for x in xs}

# toPairs :: object -> array
export toPairs = (obj) ->
    [[key, value] for key, value of obj]

