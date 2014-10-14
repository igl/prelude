'use strict'

_hasOwnProperty = Object.prototype.hasOwnProperty

# circular ugliness helper
function cloneArray (xs)
    [x for x in xs]

function reverseArray (xs)
    result = []
    i = 0
    len = xs.length
    until len is 0
        result[--len] = xs[i++]
    result

function mixin (dest = {}, ...sources)
    for src in sources then
        for key, val of src then
            dest[key] = val
    dest

# curry :: function -> number? -> function
export curry = (n, fn) ->
    if typeof n is 'function'
        fn = n
        n = fn.length

    _curry = (args) ->
        unless n > 1
        then fn
        else ->
            params = cloneArray args
            if (params.push.apply params, &) < n and &.length
            then _curry params
            else apply fn, params

    _curry []

# apply :: object -> function -> array
export apply = (f, xs) ->
    switch xs.length
    | 0 => f!
    | 1 => f xs[0]
    | 2 => f xs[0], xs[1]
    | 3 => f xs[0], xs[1], xs[2]
    | 4 => f xs[0], xs[1], xs[2], xs[3]
    | 5 => f xs[0], xs[1], xs[2], xs[3], xs[4]
    | 6 => f xs[0], xs[1], xs[2], xs[3], xs[4], xs[5]
    | 7 => f xs[0], xs[1], xs[2], xs[3], xs[4], xs[5], xs[6]
    | 8 => f xs[0], xs[1], xs[2], xs[3], xs[4], xs[5], xs[6], xs[7]
    | 9 => f xs[0], xs[1], xs[2], xs[3], xs[4], xs[5], xs[6], xs[7], xs[8]
    | _ => f.apply void, xs

export applyTo = (ctx, f, xs) ->
    switch xs.length
    | 0 => f.call ctx
    | 1 => f.call ctx, xs[0]
    | 2 => f.call ctx, xs[0], xs[1]
    | 3 => f.call ctx, xs[0], xs[1], xs[2]
    | 4 => f.call ctx, xs[0], xs[1], xs[2], xs[3]
    | 5 => f.call ctx, xs[0], xs[1], xs[2], xs[3], xs[4]
    | 6 => f.call ctx, xs[0], xs[1], xs[2], xs[3], xs[4], xs[5]
    | 7 => f.call ctx, xs[0], xs[1], xs[2], xs[3], xs[4], xs[5], xs[6]
    | 8 => f.call ctx, xs[0], xs[1], xs[2], xs[3], xs[4], xs[5], xs[6], xs[7]
    | 9 => f.call ctx, xs[0], xs[1], xs[2], xs[3], xs[4], xs[5], xs[6], xs[7], xs[8]
    | _ => f.apply ctx, xs

# flip :: function -> ...any -> any
export flip = curry 2 (f, ...xs) ->
    applyNoContext f, (reverseArray xs)

# chain :: ...function, function -> void
export chain = (...fns, cb) !->
    link = (e, ...args) !->
        if e or (fns.length is 0)
        then cb ... &
        else try applyNoContext fns.shift!, (args ++ link)
             catch => cb e
    # init chain & catch first possible error outside of link
    try fns.shift! link
    catch => cb e

# Isolated try .. catch with callback interface
# tryCatch :: function -> any
export tryCatch = (fn, cb) !->
    err = null
    res = null
    try res := fn!
    catch e
        err := if e instanceof Error then e else new Error e
    cb err, res if cb
    err or res

# Crockfordic object inheritance
# Empty Base to extend from
function Class =>

Class.prototype = Object.create null if typeof Object.create is 'function'

# Class.extend :: object -> object? -> function
Class.extend = (proto, props) ->
    parent = this
    child =
        if proto and _hasOwnProperty.call proto, 'constructor'
        then proto.constructor
        else -> applyTo this, parent, &

    mixin child, parent, props

    Surrogate = -> this.constructor = child
    Surrogate.prototype = parent.prototype
    child.prototype = new Surrogate

    mixin(child.prototype, proto) if proto
    child

export Class
