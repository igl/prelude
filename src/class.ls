'use strict'

{ mixin } = require './object'

# native methods
ObjHasOwnProperty = Object.prototype.hasOwnProperty

# Crockfordic backbonian object inheritance pattern
# Empty Base Class to extend from
!function Class
    this.initialize.apply this, arguments

Class.prototype = { initialize: !-> }

# Class.extend :: object -> object? -> function
Class.extend = (proto, props) ->
    parent = this

    # get ctor or create a new constructor which calls the parent constructor
    child =
        if proto and ObjHasOwnProperty.call proto, 'constructor'
        then proto.constructor
        else !-> parent.apply this, &

    mixin child, parent, props

    # create surrogate constructor
    Surrogate = !-> this.constructor = child
    Surrogate.prototype = parent.prototype

    child.prototype = new Surrogate

    if proto then mixin child.prototype, proto

    child

# export constructor
module.exports = Class
