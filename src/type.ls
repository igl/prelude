'use strict'

curry = require './curry'

# native methods
ObjToString = Object.prototype.toString

# match valid JSON-string
RX_ISUUID = /^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i

ALL_TYPE_CHECKS = <[ Number String Boolean Function Array Set Map Arguments Date Error RegExp Symbol Null Undefined Object ]>

# getType :: any -> string
exports.getType = ->
    for type in ALL_TYPE_CHECKS when exports["is#type"] it
        return type
    void

# primitive JS Types
exports.isNumber = isNumber = ->
    (typeof it is 'number') and (not isNaN it) and (isFinite it)

exports.isString = ->
    typeof it is 'string'

exports.isBoolean = ->
    typeof it is 'boolean'

exports.isFunction = ->
    typeof it is 'function'

exports.isArray = ->
    Array.isArray it

exports.isSet = ->
    it instanceof Set

exports.isObject = ->
    (it instanceof Object) and (Object.getPrototypeOf it) === (Object.getPrototypeOf {})

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

exports.inRange = curry (from, to, it) ->
    (isNumber it) and (from <= it) and (to >= it)
