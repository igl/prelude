'use strict'

_toString = Object.prototype.toString

# empty :: array -> boolean
export empty = (xs) ->
    xs.length is 0

# each :: function -> array -> array
export each = (f, xs) -->
    for x, i in xs then (f x, i)
    xs

# map :: function -> array -> array
export map = (f, list) -->
    [f x, i for x, i in xs]

# filter :: function -> array -> array
export filter = (f, xs) -->
    [x for x, i in xs when f x, i]

# partition :: function -> array -> [array, array]
export partition = (f, xs) -->
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
export uniqueBy = (f, xs) -->
    seen = []
    for x in xs then
        val = f x
        continue if val in seen
        seen.push val
        x

# flatten :: array -> array
export flatten = (xs) -->
    result = []
    for x in xs then
        if (_toString.call x .slice 8, -1) is 'Array'
        then result.push flatten x
        else result.push x
    result

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


# countBy :: function -> array -> array
export countBy = (f, xs) -->
    result = {}
    for x in xs
        key = f x
        if key of result
            result[key] += 1
        else
            result[key] = 1
    result

# groupBy :: function -> array -> object
export groupBy = (f, xs) -->
    result = {}
    for x in xs
        key = f x
        if key of result
            result[key].push x
        else
            result[key] = [x]
    result

# sortBy :: function -> array -> array
export sortBy = (f, xs) -->
    xs.concat!.sort (x, y) ->
        a = f x
        b = f y
        if a > b        then  1
        else if a < b   then -1
        else                  0

# splitAt :: number -> array - [array]
export splitAt = (n, xs) -->
    n = 0 if n < 0
    [(xs.slice 0, n), (xs.slice n)]

# indexOf :: any -> array -> number
export indexOf = (elem, xs) -->
    for x, i in xs
    when x is elem
        return i
    void

# indexOf :: any -> array -> number
export IndicesOf = (elem, xs) -->
    [i for x, i in xs when x is elem]

# findIndex :: function -> array -> number
export findIndex = (f, xs) -->
    for x, i in xs when f x
        return i
    void

# findIndices :: function -> array -> [number]
export findIndices = (f, xs) -->
    [i for x, i in xs when f x]

# range :: number -> number -> number -> array
export range = (a, b, inc = 1) ->
    if &.length is 1
        b = a or 0
        a = 0
    [x for x from a til b by inc]
