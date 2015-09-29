'use strict'

curry = require './curry'

# native methods
ObjToString = Object.prototype.toString

# match valid JSON-string
RX_ISUUID = /^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i

PRIMITIVE_TYPES = <[ Number String Boolean Function Array Set Map Arguments Object Date Error RegExp Symbol Null Undefined ]>
EXTENDED_TYPES  = <[ UUID Integer ]>
NONE_TYPES      = <[ Defined ]>

ALL_TYPE_CHECKS = PRIMITIVE_TYPES ++ EXTENDED_TYPES ++ NONE_TYPES

# getType :: any -> string
exports.getType = ->
    for type in PRIMITIVE_TYPES when exports["is#type"] it
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

exports.isArray = ->
    Array.isArray it

exports.isSet = ->
    it instanceof Set

exports.isObject = ->
    (it instanceof Object) and (Object.getPrototypeOf it) is (Object.getPrototypeOf {})

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

exports.isDefined = ->
    (typeof it isnt 'undefined') and (it isnt null)

exports.isNull = ->
    it is null

exports.isUndefined = ->
    (typeof it is 'undefined')

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
