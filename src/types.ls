'use strict'

curry = require './curry'

# native methods
_toString = Object.prototype.toString


# getType :: any -> string
exports.getType = (o) ->
    _toString.call o .slice 8, -1

# isType :: string -> any -> boolean
exports.isType = isType = curry 2 (t, ...xs) ->
    for x in xs
        if typeof t is 'function'
            return false unless (x instanceof t)
        else if t is 'Number'
            return false if (t isnt _toString.call x .slice 8, -1) or (isNaN x)
        else
            return false if (t isnt _toString.call x .slice 8, -1)
    true

exports.isFunction  = isType 'Function'
exports.isObject    = isType 'Object'
exports.isArray     = isType 'Array'
exports.isString    = isType 'String'
exports.isNumber    = isType 'Number'
exports.isDate      = isType 'Date'
exports.isRegExp    = isType 'RegExp'
exports.isArguments = isType 'Arguments'
exports.isError     = isType 'Error'
