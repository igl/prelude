'use strict'

curry = require './curry'

{ isType } = require './types'
{ apply } = require './funcs'
{ random } = require './numbers'

# empty :: array -> boolean
exports.empty = (xs) ->
    xs.length is 0

# has :: array -> boolean
exports.has = curry (i, xs) ->
    (i >= 0) and (i <= (xs.length - 1))

# contains :: array -> boolean
exports.contains = curry (x, xs) ->
    (xs.indexOf x) isnt -1

# clone :: array -> array
exports.clone = (xs) ->
    [x for x in xs]

# head :: array -> any
exports.first = exports.head = (xs) -> xs.0

# tail :: array -> any
exports.tail = (xs) ->
    [x for x, i in xs when i > 0]

# last :: array -> any
exports.last = (xs) -> xs[*-1]

# initial :: array -> array
exports.initial = (xs) ->
    return unless (init = xs.length)
    --init
    [x for x, i in xs when i < init]

# slice :: number -> number -> array -> array
exports.slice = curry (a, b, xs) ->
    xs.slice a, b

# concat :: number -> number -> array -> array
exports.concat = curry 2 (...xxs) ->
    result = []
    for xs in xxs then for x in xs
        result.push x
    result

# flatten :: array -> array
exports.flatten = :flatten (xs) ->
    result = []
    for x in xs
        if typeof! x is 'Array'
        then result.push.apply result, flatten x
        else result.push x
    result

# each :: function -> array -> array
exports.each = curry (f, xs) ->
    for x, i in xs then (f x, i)
    xs

# map :: function -> array -> array
exports.map = curry (f, xs) ->
    [f x, i for x, i in xs]

# filter :: function -> array -> array
exports.filter = curry (f, xs) ->
    [x for x, i in xs when f x, i]

# shuffle :: array -> array
exports.shuffle = (xs) ->
    result = new Array xs.length
    for x, i in xs
        r = random i
        result[i] = result[r] if r isnt i
        result[r] = xs[i]
    result

# reverse :: array -> array
exports.reverse = (xs) ->
    i = 0
    len = xs.length
    result = new Array len
    until len is 0
        result[--len] = xs[i++]
    result

# zip :: array -> ...array -> array
exports.zip = curry 2 (...args) ->
    min-length = 9e9
    for xs in args
        min-length <?= xs.length
    [[xs[i] for xs in args] for i til min-length]

# zip :: array -> ...array -> array
exports.zipWith = curry 3 (f, ...args) ->
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
exports.difference = curry 2 (xs, ...yss) ->
    result = []
    :diff for x in xs
        for ys in yss when x in ys
            continue diff
        result.push x
    result

# intersection :: array -> ...array -> array
exports.intersection = curry 2 (xs, ...yss) ->
    result = []
    :outer for x in xs
        for ys in yss when not (x in ys)
            continue outer unless x in ys
        result.push x
    result

# union :: ...array -> array
exports.union = curry 2 (...xss) ->
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
