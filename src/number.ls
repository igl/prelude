'use strict'

curry = require './curry'

# even :: number -> boolean
exports.even = (x) -> x % 2 == 0

# odd :: number -> boolean
exports.odd = (x) -> x % 2 != 0

# random :: number -> number -> number
exports.random = curry (min, max) ->
    min + Math.floor (Math.random! * (max - min + 1))

# range :: number -> number -> number? -> array
exports.range = curry 1 (a, b, inc = 1) ->
    [x for x from a til (b + 1) by inc]

exports.gcd = (x, y) -->
    x = Math.abs x
    y = Math.abs y
    until y is 0
        z = x % y
        x = y
        y = z
    x

exports.lcm = (x, y) -->
    Math.abs Math.floor (x / (exports.gcd x, y) * y)
