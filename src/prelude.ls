'use strict'

# native methods
_toString = Object.prototype.toString

# getType :: any -> string
exports.getType = (o) -->
    (_toString.call o .slice 8, -1)

# isType :: string -> any -> boolean
exports.isType = (t, o) -->
    (_toString.call o .slice 8, -1) is t

# export all modules
exports.string = require './string'
exports.array  = require './array'
exports.object = require './object'
exports.func   = require './func'
