'use strict'

curry = require './curry'

# native methods
ObjToString = Object.prototype.toString

# match valid JSON-string
RX_ISUUID = /^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i

PRIMITIVE_TYPES = <[ Number String Boolean Function Promise Array Set Map Arguments Object Date Error RegExp Symbol Null Undefined ]>
EXTENDED_TYPES  = <[ PlainObject UUID Integer Defined ]>

ALL_TYPE_CHECKS = PRIMITIVE_TYPES ++ EXTENDED_TYPES
ALL_TYPE_CHECKS_REV = ALL_TYPE_CHECKS.concat!reverse!

# getType :: any -> string
exports.getType = ->
    for type in PRIMITIVE_TYPES when exports["is#type"] it
        return type
    void

exports.getExtendedType = ->
    for type in ALL_TYPE_CHECKS_REV when exports["is#type"] it
        return type
    void

# primitive JS Types
exports.isNumber = ->
    (typeof it is 'number') and (not isNaN it) and (isFinite it)

exports.isString = ->
    typeof it is 'string'

exports.isBoolean = ->
    typeof it is 'boolean'

exports.isBool = exports.isBoolean

exports.isFunction = ->
    typeof it is 'function'

exports.isPromise = ->
    (typeof it is 'object') and (it.constructor and it.constructor.name === 'Promise')

exports.isArray = ->
    Array.isArray it

exports.isSet = ->
    it instanceof Set

exports.isObject = ->
    (it isnt null)
    and (typeof it === 'object')
    and not(it instanceof Error)
    and not(it instanceof Date)
    and not(it instanceof Set)
    and not(it instanceof Map)
    and not(it instanceof RegExp)
    and not(Array.isArray it)

exports.isMap = ->
    it instanceof Map

exports.isArguments = ->
    (ObjToString.call it) is '[object Arguments]'

exports.isDate = ->
    it instanceof Date

exports.isError = ->
    it instanceof Error

exports.isRegExp = ->
    it instanceof RegExp

exports.isSymbol = ->
    typeof it is 'symbol'

exports.isNull = ->
    it is null

exports.isUndefined = ->
    (typeof it is 'undefined')

# extended types
exports.isPlainObject = ->
    (it instanceof Object) and (Object.getPrototypeOf it) is (Object.getPrototypeOf {})

exports.isDefined = ->
    (typeof it isnt 'undefined') and (it isnt null)

exports.isUUID = ->
    (typeof it is 'string') and (RX_ISUUID.test it)

exports.isInteger = ->
    (not isNaN it) and (it % 1 is 0)

exports.isInt = exports.isInteger

exports.inRange = curry (from, to, it) ->
    (exports.isNumber it) and (from <= it) and (to >= it)

# generate is<type>Array functions
ALL_TYPE_CHECKS.forEach (type) ->
    exports["is#{type}Array"] = ->
        (Array.isArray it) and (it.length > 0) and (it.every exports["is#{type}"])

exports.isBoolArray = exports.isBooleanArray

exports.isIntArray  = exports.isIntegerArray

# oneOf :: ...any -> (any -> bool)
exports.oneOf = (...xs) -> (a) ->
    for x in xs when x is a then return true
    false
