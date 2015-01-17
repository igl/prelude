'use strict'

# curry :: function -> number? -> function
module.exports = (n, fn) ->
    if typeof n is 'function'
        fn = n
        n = fn.length
    else
        n += 1

    function curry (args)
        ->
            params = args.slice!
            if (params.push.apply params, &) < n
            then curry params
            else fn.apply void, params

    if n > 0
    then curry []
    else fn
