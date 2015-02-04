'use strict'

curry = require './curry'

# native methods
ObjToString = Object.prototype.toString

# match valid JSON-string
RX_ISJSON = /^[ ]*[\[\{].*[\]\}][ ]*$/
RX_ISUUID = /^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i

ALL_TYPE_CHECKS = <[ Number String Boolean Function Array Set Object Map Arguments Date Error RegExp Symbol ]>

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
    (ObjToString.call it) is '[object Array]'

exports.isSet = ->
    (ObjToString.call it) is '[object Set]'

exports.isObject = ->
    (ObjToString.call it) is '[object Object]'

exports.isMap = ->
    (ObjToString.call it) is '[object Map]'

exports.isArguments = ->
    (ObjToString.call it) is '[object Arguments]'

exports.isDate = ->
    (ObjToString.call it) is '[object Date]'

exports.isError = ->
    (ObjToString.call it) is '[object Error]'

exports.isRegExp = ->
    (ObjToString.call it) is '[object RegExp]'

exports.isSymbol = ->
    (ObjToString.call it) is '[object Symbol]'

# advanced value-type checks
exports.isJSON = ->
    if typeof it isnt 'string'
        return false

    if not RX_ISJSON.test it
        return false

    try JSON.parse it
    catch
        return false
    true

exports.isUUID = ->
    (typeof it is 'string') and (RX_ISUUID.test it)

exports.isInteger = ->
    (not isNaN it) and (it % 1 is 0)

exports.inRange = curry (from, to, it) ->
    (isNumber it) and (from <= it) and (to >= it)
