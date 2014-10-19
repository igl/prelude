'use strict'

curry = require './curry'

# even :: number -> boolean
exports.even = (x) -> x % 2 == 0

# odd :: number -> boolean
exports.odd = (x) -> x % 2 != 0

# random :: number -> number -> number
exports.random = (min, max) ->
    if max ~= null
        max = min
        min = 0
    min + Math.floor (Math.random! * (max - min + 1))

# range :: number -> number -> number? -> array
exports.range = curry 2 (a, b, inc = 1) ->
    if &.length is 1
        b = a or 0
        a = 0
    [x for x from a til b by inc]

exports.gcd = (x, y) -->
    x = Math.abs x
    y = Math.abs y
    until y is 0
        z = x % y
        x = y
        y = z
    x

exports.lcm = (x, y) -->
    Math.abs Math.floor (x / (gcd x, y) * y)
