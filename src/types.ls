'use strict'

# native methods
ObjToString = Object.prototype.toString

# match valid JSON-string
RX_ISJSON = /^[ ]*[\[\{].*[\]\}][ ]*$/

# getType :: any -> string
exports.getType = ->
    ObjToString.call it .slice 8, -1

# basic Types
exports.isNumber = ->
    (typeof it is 'number') and (not isNaN it) and (isFinite it)

exports.isString = ->
    typeof it is 'string'

exports.isBoolean = ->
    typeof it is 'boolean'

exports.isFunction = ->
    typeof it is 'function'

exports.isArray = ->
    (ObjToString.call it .slice 8, -1) is 'Array'

exports.isObject = ->
    (ObjToString.call it .slice 8, -1) is 'Object'

exports.isArguments = ->
    (ObjToString.call it .slice 8, -1) is 'Arguments'

exports.isDate = ->
    (ObjToString.call it .slice 8, -1) is 'Date'

exports.isError = ->
    (ObjToString.call it .slice 8, -1) is 'Error'

exports.isRegExp = ->
    (ObjToString.call it .slice 8, -1) is 'RegExp'

# advanced value type checks
exports.isJSON = ->
    if typeof it isnt 'string'
        return false

    if not RX_ISJSON.test it
        return false

    try JSON.parse it
    catch
        return false
    true

exports.isInteger = ->
    (not isNaN it) and (it % 1 is 0)

exports.inRange = (from, to, it) ->
    (from <= it) and (to >= it)
