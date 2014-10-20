'use strict'

<-! suite 'prelude.object'

{
    empty, keys, values, clone, each, map, filter,
    mixin, deepMixin, fill, deepFill, freeze, deepFreeze
} = prelude.objects

suite 'empty()' !->
    test 'returns correctly with valid inputs' !->
        strictEqual (empty {}), true
        strictEqual (empty { a: 1 }), false

suite 'keys()' !->
    test 'return keys' !->
        deepEqual do
            keys { a:1, b:2 }
            <[a b]>

suite 'values()' !->
    test 'return values' !->
        deepEqual do
            values { a:1, b:2 }
            [1 2]

suite 'clone()' !->
    test 'returns the same as input' !->
        deepEqual do
            clone { a: 12 }
            { a: 12 }

    test 'returns a copy' !->
        original = { a:0, b:1, c:2 }
        copy     = clone original
        copy.a   = 'foo'

        strictEqual original.a, 0
        strictEqual copy.a, 'foo'

suite 'each()' !->
    test 'curries' !->
        isFunction each (->)
        isObject each (->), { a:1, b:2, c:3 }

    test 'iterates over the complete object' !->
        count = 0
        each (-> ++count), { a:1, b:2, c:3 }
        strictEqual count, 3

    test 'iterator receives key and value' !->
        { a:1, b:2, c:3 } |> each (value, key) !->
            isNumber value
            isString key
            if key is 'a' then strictEqual value, 1
            if key is 'b' then strictEqual value, 2
            if key is 'c' then strictEqual value, 3

suite 'map()' !->
    test 'curries' !->
        isFunction map (->)
        isObject   map (->), { a:1, b:2, c:3 }

    test 'iterates over the complete object' !->
        count = 0
        map (-> ++count), { a:1, b:2, c:3 }
        strictEqual count, 3

    test 'iterator receives key and value' !->
        { a:0, b:1, c:2 } |> map (value, key) !->
            isNumber value
            isString key
            if key is 'a' then strictEqual value, 0
            if key is 'b' then strictEqual value, 1
            if key is 'c' then strictEqual value, 2

    test 'remap values' !->
        deepEqual do
            map (-> it + 1), { a:0, b:1, c:2 }
            { a:1, b:2, c:3 }

suite 'filter()' !->
    test 'curries' !->
        isFunction filter (->)
        isObject filter (->), { a:0, b:1, c:2 }

    test 'iterates over the complete object' !->
        count = 0
        filter (-> ++count), { a:0, b:1, c:2 }
        strictEqual count, 3

    test 'iterator receives key and value' !->
        { a:0, b:1, c:2 } |> filter (value, key) ->
            isNumber value
            isString key
            if key is 'a' then strictEqual value, 0
            if key is 'b' then strictEqual value, 1
            if key is 'c' then strictEqual value, 2

    test 'filters values' !->
        deepEqual do
            filter (-> typeof it isnt 'string'), { a:0, b:'foo', c:2 }
            { a:0, c:2 }

suite 'mixin()' !->
    test 'curries' !->
        deepEqual do
            { b:2 } |> mixin { a:1 }
            { a:1, b:2 }

    test 'add to object' !->
        deepEqual do
            mixin { a:1 }, { b:2 }
            { a:1, b:2 }

    test 'add to new object' !->
        deepEqual do
            mixin null, { a:1 }, { b:2 }
            { a:1, b:2 }

suite 'deepMixin()' !->
    test 'curries' !->
        deepEqual do
            { b:{ d:3 }} |> deepMixin { a:1, b:{ c:2 }}
            { a:1, b:{ c:2, d:3 }}

    test 'add to object' !->
        deepEqual do
            deepMixin { a:1, b:{ c:2 }}, { b:{ d:3 }}
            { a:1 b:{ c:2, d:3 }}

    test 'add to new object' !->
        deepEqual do
            deepMixin null, { a:1, b:{ c:2 }}, { b:{ d:3 }}
            { a:1 b:{ c:2, d:3 }}

suite 'fill()' !->
    test 'curries' !->
        deepEqual do
            { a:10, b:20 } |> fill { a:1 }
            { a:10 }

    test 'fill object' !->
        deepEqual do
            fill { a:1 }, { a:10, b:20 }
            { a:10 }

suite 'deepFill()' !->
    test 'curries' !->
        deepEqual do
            { a:10, b:{ c:20, d:30 }} |> deepFill { a:1, b:{ c:2 }}
            { a:10, b:{ c:20, }}

    test 'fill object' !->
        deepEqual do
            deepFill { a:1, b:{ c:2 }}, { a:10, b:{ c:20, d:30 }}
            { a:10, b:{ c:20, }}

suite 'freeze()' !->
    obj = freeze { a:1, b:{ c:2 }}
    test 'freeze object' !->
        throws (-> obj.a = 20), (-> true)

    test 'do not freeze child objects' !->
        obj.b.c = 10
        strictEqual obj.b.c, 10

suite 'deepFreeze()' !->
    obj = deepFreeze { a:1, b:{ c:2 }}
    test 'freeze object' !->
        throws (-> obj.a = 20), (-> true)

    test 'freeze child objects' !->
        throws (-> obj.b.c = 10), (-> true)
