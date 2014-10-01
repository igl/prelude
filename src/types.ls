'use strict'

{ curry } = require './funcs'

# native methods
_toString = Object.prototype.toString


# getType :: any -> string
export getType = (o) ->
    _toString.call o .slice 8, -1

# isType :: string -> any -> boolean
export isType = curry (t, o) ->
    t is _toString.call o .slice 8, -1
