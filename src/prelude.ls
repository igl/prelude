'use strict'

# export all
exports.array  = require './array'
exports.object = require './object'
exports.string = require './string'
exports.number = require './number'
exports.fn     = require './fn'
exports.type   = require './type'

root = this

# importAll :: object? -> object
exports.importAll = (target) !->
    { capitalize } = exports.string
    unless target
        if typeof exports isnt 'undefined'
        and typeof module isnt 'undefined'
        and module.exports
        and global
            target = global
        else
            target = root

    for typeName, type of exports => for methodName, method of type
        target[typeName ++ (capitalize methodName)] = method

    target
