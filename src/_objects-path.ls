'use strict'

rx_parseJSPath  = /\[("|'|)(.*?)\1\]|([^.\[\]]+)/g

# Repeatedly capture either:
# - a bracketed expression, discarding optional matching quotes inside, or
# - an unbracketed expression, delimited by a dot or a bracket.
# - taken from http://codereview.stackexchange.com/questions/62997/javascript-path-parsing/63010#63010
# parseJavaScriptPathIntoKeyNames :: string -> array
function parseJavaScriptPathIntoKeyNames (path)
    var token, result

    result = []

    while (token = rx_parseJSPath.exec path) !~= null
        result.push (token.2 or token.3)

    result

exports.getPath = curry (obj, ks) ->
    i   = -1
    len = ks.length
    ks  =
        if typeof ks is 'string'
            parseJavaScriptPathIntoKeyNames ks
        else if isType 'Array' ks
            ks
        else
            throw new Error 'invalid argument (string | array)'

    while ++i < len and obj?
        obj = obj[ks[i]]

    if i is len then obj else void

exports.hasPath = curry (obj, ks) ->
    i   = -1
    len = ks.length
    ks  =
        if typeof ks is 'string'
            parseJavaScriptPathIntoKeyNames ks
        else if isType 'Array' ks
            ks
        else
            throw new Error 'invalid argument (string | array)'
    while (++i < len) and obj?
        if ks[i] of obj then
            obj = obj[ks[i]]
        else
            return false
    i is len
