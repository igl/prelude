'use strict'

# curry :: function -> number? -> function
module.exports = (n, fn) ->
    if typeof n is 'function'
        fn = n
        n = fn.length
    else
        n += 1

    function curry (args)
        unless n > 1
        then fn
        else ->
            params = args.slice!
            if (params.push.apply params, &) < n
            then curry params
            else fn.apply void, params

    curry []
