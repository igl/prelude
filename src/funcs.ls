'use strict'

curry = require './curry'

# native methods
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

# noop :: any -> any
exports.noop = -> it

# curry :: function -> number? -> function
exports.curry = curry

# apply :: object -> function -> array
apply = exports.apply = curry (f, xs) ->
    switch xs.length
    | 0 => f!
    | 1 => f xs.0
    | 2 => f xs.0, xs.1
    | 3 => f xs.0, xs.1, xs.2
    | 4 => f xs.0, xs.1, xs.2, xs.3
    | 5 => f xs.0, xs.1, xs.2, xs.3, xs.4
    | 6 => f xs.0, xs.1, xs.2, xs.3, xs.4, xs.5
    | 7 => f xs.0, xs.1, xs.2, xs.3, xs.4, xs.5, xs.6
    | 8 => f xs.0, xs.1, xs.2, xs.3, xs.4, xs.5, xs.6, xs.7
    | 9 => f xs.0, xs.1, xs.2, xs.3, xs.4, xs.5, xs.6, xs.7, xs.8
    | _ => f.apply void, xs

applyTo = exports.applyTo = curry (ctx, f, xs) ->
    switch xs.length
    | 0 => f.call ctx
    | 1 => f.call ctx, xs.0
    | 2 => f.call ctx, xs.0, xs.1
    | 3 => f.call ctx, xs.0, xs.1, xs.2
    | 4 => f.call ctx, xs.0, xs.1, xs.2, xs.3
    | 5 => f.call ctx, xs.0, xs.1, xs.2, xs.3, xs.4
    | 6 => f.call ctx, xs.0, xs.1, xs.2, xs.3, xs.4, xs.5
    | 7 => f.call ctx, xs.0, xs.1, xs.2, xs.3, xs.4, xs.5, xs.6
    | 8 => f.call ctx, xs.0, xs.1, xs.2, xs.3, xs.4, xs.5, xs.6, xs.7
    | 9 => f.call ctx, xs.0, xs.1, xs.2, xs.3, xs.4, xs.5, xs.6, xs.7, xs.8
    | _ => f.apply ctx, xs

exports.applyNew = curry (F, xs) ->
    switch xs.length
    | 0 => new F
    | 1 => new F xs.0
    | 2 => new F xs.0, xs.1
    | 3 => new F xs.0, xs.1, xs.2
    | 4 => new F xs.0, xs.1, xs.2, xs.3
    | 5 => new F xs.0, xs.1, xs.2, xs.3, xs.4
    | 6 => new F xs.0, xs.1, xs.2, xs.3, xs.4, xs.5
    | 7 => new F xs.0, xs.1, xs.2, xs.3, xs.4, xs.5, xs.6
    | 8 => new F xs.0, xs.1, xs.2, xs.3, xs.4, xs.5, xs.6, xs.7
    | 9 => new F xs.0, xs.1, xs.2, xs.3, xs.4, xs.5, xs.6, xs.7, xs.8
    | _ =>
        Surrogate = !-> F.apply this, xs
        Surrogate.prototype = F.prototype
        return new Surrogate

# flip :: function -> ...any -> any
exports.flip = curry 2 (f, ...xs) ->
    -> apply f, (reverseArray xs)

function doubleCallback
    throw new Error

# chain :: ...function, function -> void
exports.chain = (...fns, done) !->
    link = (err, ...args) !->
        if err or (fns.length is 0)
            apply done, &
            return

        try apply fns.shift!, (args ++ link)
        catch => immediate -> done e

    try fns.shift! link
    catch =>
        immediate -> done e

# concurrent :: ...function -> function
exports.concurrent = (...fns, cb) !->
    len     = fns.length
    errors  = new Array len
    results = new Array len

    link = (i) -> (err, ...args) !->
        errors[i]  = e
        results[i] = args
        cb errors, results if --len is 0

    for fn, i in fns
        try (fn link i)
        catch then errors[i] = e

# delay :: number -> function -> object
exports.delay = curry (msec, f) ->
    i = 0
    iv = setInterval do
        !-> (clearInterval iv) if (f i++) isnt false
        msec

# interval :: number -> function -> object
exports.interval = curry (msec, f) ->
    i = 0
    iv = setInterval do
        !-> (clearInterval iv) if (f i++) is false
        msec

immediate = exports.immediate = (f) ->
    if (typeof setImmediate === 'function')
        setImmediate f
    else if (typeof process !== 'undefined' and process.nextTick)
        process.nextTick f
    else
        setTimeout f, 0


# Isolated try .. catch with callback interface
# tryCatch :: function -> any
exports.tryCatch = (fn, cb) ->
    try
        res = fn!
    catch
        err = if e instanceof Error then e else new Error e
    cb err, res if typeof cb is 'function'
    err or res

# Crockfordic backbonian object inheritance
# Empty Base Class to extend from
!function Class
    this.initialize.apply this, arguments

Class.prototype = { initialize: !-> }

# Class.extend :: object -> object? -> function
Class.extend = (proto, props) ->
    parent = this

    # get child from proto or create empty constructor which calls parent constructor
    child =
        if proto and _hasOwnProperty.call proto, 'constructor'
        then proto.constructor
        else !-> applyTo this, parent, &

    mixin child, parent, props

    Surrogate = !-> this.constructor = child
    Surrogate.prototype = parent.prototype
    child.prototype = new Surrogate

    if proto then mixin child.prototype, proto

    return child

exports.Class = Class
