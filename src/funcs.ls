'use strict'

curry = require './curry'

# native methods
_hasOwnProperty = Object.prototype.hasOwnProperty

# chicken and egg helper
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

function doubleCallback
    throw new Error 'chain() callback called twice!'

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
exports.flip = curry 1 (f, ...xs) ->
    -> apply f, (reverseArray xs)

# chain :: ...function, function -> void
exports.chain = (...fns, done) !->
    # jump out of try-catch stack with immediate
    callback = (...args) !-> immediate !->
        apply done, args
        done := doubleCallback

    link = (err, ...args) !->
        if err or (fns.length is 0)
            apply callback, &
            return

        # try-catch next call
        try apply fns.shift!, (args ++ link)
        catch => callback e

    # try-catch first call
    try fns.shift! link
    catch => callback e

# concurrent :: ...function -> function -> void
exports.concurrent = (...fns, done) !->
    len     = fns.length
    errors  = new Array len
    results = new Array len

    # jump out of try-catch stack with immediate
    callback = (...args) !-> immediate !->
        done errors, results
        done := doubleCallback

    link = (i) -> (err, ...args) !->
        errors[i]  = if err then err else void
        results[i] = if args.length then args else void
        callback! if --len is 0

    for fn, i in fns
        try (fn link i)
        catch then errors[i] = e

# delay :: number -> function -> object
exports.delay = curry (msec, fn) ->
    i = 0
    iv = setInterval do
        !-> (clearInterval iv) if (fn i++) isnt false
        msec

# interval :: number -> function -> object
exports.interval = curry (msec, fn) ->
    i = 0
    iv = setInterval do
        !-> (clearInterval iv) if (fn i++) is false
        msec

# immediate :: function -> function
immediate = exports.immediate = (fn) ->
    if (typeof setImmediate is 'function')
        setImmediate fn
    else if process?.nextTick
        process.nextTick fn
    else
        setTimeout fn, 0
    fn

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

    # get child from proto or create a new constructor which calls parent constructor
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
