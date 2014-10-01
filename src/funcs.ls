'use strict'

# circular ugliness
cloneArray = (xs) -> [x for x in xs]

# applyNoContext :: function -> array
function applyNoContext (f, args)
    switch args.length
    | 0 => f!
    | 1 => f args[0]
    | 2 => f args[0], args[1]
    | 3 => f args[0], args[1], args[2]
    | 4 => f args[0], args[1], args[2], args[3]
    | 5 => f args[0], args[1], args[2], args[3], args[4]
    | 6 => f args[0], args[1], args[2], args[3], args[4], args[5]
    | 7 => f args[0], args[1], args[2], args[3], args[4], args[5], args[6]
    | 8 => f args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]
    | 9 => f args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]
    | _ => f.apply void, args

# applyWithContext :: function -> array
function applyWithContext (context, f, args)
    switch args.length
    | 0 => f.call context
    | 1 => f.call context, args[0]
    | 2 => f.call context, args[0], args[1]
    | 3 => f.call context, args[0], args[1], args[2]
    | 4 => f.call context, args[0], args[1], args[2], args[3]
    | 5 => f.call context, args[0], args[1], args[2], args[3], args[4]
    | 6 => f.call context, args[0], args[1], args[2], args[3], args[4], args[5]
    | 7 => f.call context, args[0], args[1], args[2], args[3], args[4], args[5], args[6]
    | 8 => f.call context, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]
    | 9 => f.call context, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]
    | _ => f.apply context, args

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
            if (params.push.apply params, arguments) < n
            then _curry params
            else applyNoContext fn, params

    _curry []

# apply :: object -> function -> array
export apply = curry 2 (f, args, context) ->
    if context?
    then applyWithContext context, f, args
    else applyNoContext f, args

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
    if cb then cb err, res
    err or res
