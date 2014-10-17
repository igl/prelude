'use strict'

{ isType } = require './types'
{ curry, apply } = require './funcs'
{ random } = require './numbers'

# empty :: array -> boolean
export empty = (xs) ->
    xs.length is 0

# clone :: array -> array
export clone = (xs) ->
    [x for x in xs]

# head :: array -> any
export head = (xs) -> xs.0

# head :: array -> any
export first = head

# tail :: array -> any
export tail = (xs) ->
    [x for x, i in xs when i > 0]

# last :: array -> any
export last = (xs) -> xs[*-1]

# initial :: array -> array
export initial = (xs) ->
    return unless (init = xs.length)
    --init
    [x for x, i in xs when i < init]

# each :: function -> array -> array
export each = curry (f, xs) ->
    for x, i in xs then (f x, i)
    xs

# slice :: number -> number -> array -> array
export slice = curry (a, b, xs) ->
    xs.slice a, b

# map :: function -> array -> array
export map = curry (f, xs) ->
    [f x, i for x, i in xs]

# filter :: function -> array -> array
export filter = curry (f, xs) ->
    [x for x, i in xs when f x, i]

# flatten :: array -> array
export flatten = curry (xs) ->
    result = []
    for x in xs then
        if isType 'Array', x
        then result.push (flatten x)
        else result.push x
    result

# shuffle :: array -> array
export shuffle = (xs) ->
    result = new Array xs.length
    for x, i in xs
        r = random i
        result[i] = result[r] if r isnt i
        result[r] = xs[i]
    result

# reverse :: array -> array
export reverse = (xs) ->
    result = []
    i = 0
    len = xs.length
    until len is 0
        result[--len] = xs[i++]
    result

# zip :: array -> ...array -> array
export zip = curry 2 (...args) ->
    min-length = 9e9
    for xs in args
        min-length <?= xs.length
    [[xs[i] for xs in args] for i til min-length]

# zip :: array -> ...array -> array
export zipWith = curry 3 (f, ...args) ->
    min-length = 9e9
    for xs in args
        min-length <?= xs.length
    [(apply f, [xs[i] for xs in args]) for i til min-length]

# partition :: function -> array -> [array, array]
export partition = curry (f, xs) ->
    passed = []
    failed = []
    for x in xs then
        (if f x then passed else failed).push x
    [passed, failed]

# unique :: array -> array
export unique = (xs) ->
    result = []
    for x in xs when x not in result then
        result.push x
    result

# uniqueBy :: function -> array -> array
export uniqueBy = curry (f, xs) ->
    seen = []
    for x in xs then
        val = f x
        continue if val in seen
        seen.push val
        x

# difference :: array -> ...array -> array
export difference = (xs, ...yss) ->
    result = []
    :outer for x in xs
        for ys in yss when x in ys
            continue outer
        result.push x
    result

# intersection :: array -> ...array -> array
export intersection = (xs, ...yss) ->
    result = []
    :outer for x in xs
        for ys in yss when not (x in ys)
            continue outer unless x in ys
        result.push x
    result

# union :: ...array -> array
export union = (...xss) ->
    result = []
    for xs in xss
        for x in xs when not x in result
            result.push x
    result

# sortBy :: function -> array -> array
export sortBy = curry (f, xs) ->
    xs.concat!.sort (x, y) ->
        a = f x
        b = f y
        if a > b        then  1
        else if a < b   then -1
        else                  0

# countBy :: function -> array -> array
export countBy = curry (f, xs) ->
    result = {}
    for x in xs
        key = f x
        if key of result
            result[key] += 1
        else
            result[key] = 1
    result

# groupBy :: function -> array -> object
export groupBy = curry (f, xs) ->
    result = {}
    for x in xs
        key = f x
        if key of result
            result[key].push x
        else
            result[key] = [x]
    result

# splitAt :: number -> array - [array]
export splitAt = curry (n, xs) ->
    n = 0 if n < 0
    [(xs.slice 0, n), (xs.slice n)]

# index :: any -> array -> number
export index = curry (elem, xs) ->
    for x, i in xs
    when x is elem
        return i
    void

# indicesOf :: any -> array -> [number]
export indices = curry (elem, xs) ->
    [i for x, i in xs when x is elem]

# findIndex :: function -> array -> number
export findIndex = curry (f, xs) ->
    for x, i in xs when f x
        return i
    void

# findIndices :: function -> array -> [number]
export findIndices = curry (f, xs) ->
    [i for x, i in xs when f x]
