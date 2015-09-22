'use strict'

curry  = require './curry'
number = require './number'
object = require './object'

{ isArray, isObject } = require './type'
{ apply } = require './func'

# empty :: array -> boolean
exports.empty = (xs) ->
    xs.length is 0

# has :: array -> boolean
exports.has = curry (i, xs) ->
    (i >= 0) and (i <= (xs.length - 1))

# includes :: array -> boolean
exports.includes = curry (y, xs) ->
    for x in xs when x is y
        return true
    false

exports.contains = exports.includes

# clone :: array -> array
exports.clone = (xs) ->
    copy = []
    for value, i in xs
        if isObject value
            copy[i] = object.deepAssign {}, value

        else if isArray value
            copy[i] = exports.clone value

        else
            copy[i] = value
    copy

# head :: array -> any
exports.first = exports.head = (xs) -> xs.0

# tail :: array -> any
exports.rest = exports.tail = (xs) ->
    [x for x, i in xs when i > 0]

# last :: array -> any
exports.last = (xs) -> xs[*-1]

# initial :: array -> array
exports.initial = (xs) ->
    return [] unless (init = xs.length)
    --init
    [x for x, i in xs when i < init]

# slice :: number -> number -> array -> array
exports.slice = curry (a, b, xs) ->
    xs.slice a, b

# concat :: array* -> array
exports.concat = curry 1 (...xxs) ->
    result = []
    for xs in xxs then for x in xs
        result.push x
    result

# remove :: any -> array -> array
exports.remove = curry 1 (y, xs) ->
    [ x for x in xs when x isnt y ]

# remove :: any -> array -> array
exports.removeOne = curry 1 (y, xs) ->
    result = []
    foundOne = false
    for x in xs
        if x is y and not foundOne
        then foundOne := true
        else result.push x
    result

# flatten :: array -> array
exports.flatten = :flatten (xs) ->
    result = []
    for x in xs
        if isArray x
        then result.push ...(flatten x)
        else result.push x
    result

# reverse :: array -> array
exports.reverse = (xs) ->
    i = 0
    len = xs.length
    result = new Array len
    until len is 0
        result[--len] = xs[i++]
    result

# each :: function -> array -> array
exports.each = curry (f, xs) ->
    for x, i in xs then (f x, i)
    xs

# map :: function -> array -> array
exports.map = curry (f, xs) ->
    [f x, i for x, i in xs]

# filter :: function -> array -> array
exports.find = exports.filter = curry (f, xs) ->
    [x for x, i in xs when f x, i]

# find :: elem -> array -> elem | undefined
exports.findOne = curry (f, xs) !->
    for x, i in xs when f x, i
        return x

# shuffle :: array -> array
exports.shuffle = (xs) ->
    result = new Array xs.length
    for x, i in xs
        r = number.random i
        result[i] = result[r] if r isnt i
        result[r] = xs[i]
    result

# every :: function -> array -> array
exports.every = curry (f, xs) ->
    for x, i in xs when (f x, i) is false
        return false
    true

# some :: function -> array -> array
exports.some = curry (f, xs) ->
    for x, i in xs when (f x, i) is true
        return true
    false

# zip :: array -> ...array -> array
exports.zip = curry 1 (...args) ->
    min-length = 9e9
    for xs in args
        min-length <?= xs.length
    [[xs[i] for xs in args] for i til min-length]

# zip :: array -> ...array -> array
exports.zipWith = curry 2 (f, ...args) ->
    min-length = 9e9
    for xs in args
        min-length <?= xs.length
    [(apply f, [xs[i] for xs in args]) for i til min-length]

# partition :: function -> array -> [array, array]
exports.partition = curry (f, xs) ->
    passed = []
    failed = []
    for x in xs
        (if f x then passed else failed).push x
    [passed, failed]

# unique :: array -> array
exports.unique = (xs) ->
    result = []
    for x in xs when x not in result
        result.push x
    result

# uniqueBy :: function -> array -> array
exports.uniqueBy = curry (f, xs) ->
    seen = []
    for x in xs
        val = f x
        continue if val in seen
        seen.push val
        x

# difference :: array -> ...array -> array
exports.difference = curry 1 (xs, ...yss) ->
    result = []
    :diff for x in xs
        for ys in yss when x in ys
            continue diff
        result.push x
    result

# intersection :: array -> ...array -> array
exports.intersection = curry 1 (xs, ...yss) ->
    result = []
    :outer for x in xs
        for ys in yss when not (x in ys)
            continue outer
        result.push x
    result

# union :: ...array -> array
exports.union = curry 1 (...xss) ->
    result = []
    for xs in xss
        for x in xs when x not in result
            result.push x
    result

# sortBy :: function -> array -> array
exports.sortBy = curry (f, xs) ->
    xs.concat!.sort (x, y) ->
        a = f x
        b = f y
        if a > b        then  1
        else if a < b   then -1
        else                  0

# countBy :: function -> array -> array
exports.countBy = curry (f, xs) ->
    result = {}
    for x in xs
        key = f x
        if key of result
            result[key] += 1
        else
            result[key] = 1
    result

# groupBy :: function -> array -> object
exports.groupBy = curry (f, xs) ->
    result = {}
    for x in xs
        key = f x
        if key of result
            result[key].push x
        else
            result[key] = [x]
    result

# splitAt :: number -> array - [array]
exports.splitAt = curry (n, xs) ->
    n = 0 if n < 0
    [(xs.slice 0, n), (xs.slice n)]

# index :: any -> array -> number
exports.index = curry (elem, xs) ->
    for x, i in xs
    when x is elem
        return i
    void

# indicesOf :: any -> array -> [number]
exports.indices = curry (elem, xs) ->
    [i for x, i in xs when x is elem]

# findIndex :: function -> array -> number
exports.findIndex = curry (f, xs) ->
    for x, i in xs when f x
        return i
    void

# findIndices :: function -> array -> [number]
exports.findIndices = curry (f, xs) ->
    [i for x, i in xs when f x]
