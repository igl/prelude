'use strict'

curry = require './curry'

function doubleCallback
    throw new Error 'chain() callback called twice!'

# id :: any -> any
exports.id = (a) -> a

# curry :: function -> number? -> function
exports.curry = curry

# compose :: function -> ...function -> any
exports.compose = (...fns) -> ->
    i      = fns.length
    result = apply fns[--i], &
    [result = fns[i] result while i--]
    result

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
    i = 0
    len = xs.length
    result = Array len
    until len is 0
        result[--len] = xs[i++]
    -> apply f, result

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
exports.immediate = (fn) ->
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

    if typeof cb is 'function'
        cb err, res

    err or res
