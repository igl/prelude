'use strict'

RX_ISJSON = /^[\[\{].*[\]\}]$/

# native methods
ObjToString = Object.prototype.toString

# getType :: any -> string
exports.getType = (o) ->
    ObjToString.call o .slice 8, -1

# Basic Types
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

# Advanced value checks
exports.isJSON = ->
    if typeof it isnt 'string'
        return false

    if not RX_ISJSON.test it
        return false

    try JSON.parse it
    catch
        return false
    true

exports.isInt
