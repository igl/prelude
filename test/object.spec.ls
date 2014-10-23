'use strict'

<-! suite 'prelude.object'

{
    empty, keys, values, clone, each, map, filter, partition, keyOf, keysOf,
    findKey, findKeys, fromPairs, toPairs, has, getPath, hasPath, fill,
    deepFill, mixin, deepMixin, freeze, deepFreeze, toString, fromString,
    definePublic, definePrivate, defineStatic, defineMeta
} = prelude.objects

suite 'empty()' !->
    test 'returns correctly with valid inputs' !->
        strictEqual (empty {}), true
        strictEqual (empty { a: 1 }), false

suite 'has()' !->
    test 'has property' !->
        strictEqual do
            has 'a', { a:1, b:2, c:3 }
            true

    test 'does not have property' !->
        strictEqual do
            has 'd', { a:1, b:2, c:3 }
            false

# suite 'hasPath()' !->
#     obj = { a: { b: { c: 'foo'}}}
#     test 'properties exists' !->
#         strictEqual true, true

# suite 'getPath()' !->
#     obj = { a:{ b:{ c:'foo' } } }
#     test 'gets property' !->
#         strictEqual (getPath obj, 'a.b.c'), 'foo'

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

suite 'partition()' !->
    test 'curries' !->
        isFunction partition (->)
        result = partition (->), { a:0, b:1, c:2 }
        isArray result
        isObject result.0
        isObject result.1

    test 'iterates over the complete object' !->
        count = 0
        partition (!-> ++count), { a:0, b:1, c:2 }
        strictEqual count, 3

    test 'iterator receives key and value' !->
        { a:0, b:1, c:2 } |> partition (value, key) !->
            isNumber value
            isString key
            if key is 'a' then strictEqual value, 0
            if key is 'b' then strictEqual value, 1
            if key is 'c' then strictEqual value, 2

    test 'partitions object' !->
        deepEqual do
            partition (-> it < 2), { a:0, b:1, c:2, d:3 }
            [{ a:0, b:1 }, { c:2, d:3 }]


suite 'keyOf()' !->
    test 'find key' !->
        strictEqual (keyOf 'foo', { a:'foo', b:'bar'}), 'a'

suite 'keysOf()' !->
    test 'find keys' !->
        deepEqual do
            keysOf 'foo', { a:'bar', b:'foo', c:'bar', d:'foo'}
            ['b','d']

suite 'findKey()' !->
    test 'find keys' !->
        deepEqual do
            findKey (-> it is 'foo'), { a:'bar', b:'foo', c:'bar'}
            'b'

suite 'findKeys()' !->
    test 'find keys' !->
        deepEqual do
            findKeys (-> it is 'foo'), { a:'bar', b:'foo', c:'bar', d:'foo'}
            ['b','d']

suite 'fromPairs()' !->
    test 'create object from pair' !->
        deepEqual do
            fromPairs [['a', 1],['b', 2]]
            { a:1, b:2 }

suite 'toPairs()' !->
    test 'create object from pair' !->
        deepEqual do
            toPairs { a:1, b:2 }
            [['a',1],['b',2]]

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

suite 'toString()' !->
    test 'convert object to string' !->
        strictEqual do
            toString { a:1, b:{ c:2 }}
            '''{
              "a": 1,
              "b": {
                "c": 2
              }
            }'''

suite 'fromString()' !->
    test 'convert string to object' !->
        deepEqual do
            fromString '{"a":1,"b":{"c":2}}'
            { a:1, b:{ c:2 }}

suite 'definePublic()' !->
    test 'define enumerable property' !->
        deepEqual do
            definePublic {}, 'foo', 'bar'
            { foo: 'bar' }

suite 'definePrivate()' !->
    test 'define hidden property' !->
        res = definePrivate {}, 'foo', 'bar'
        deepEqual res, {}
        strictEqual res.foo, 'bar'

suite 'defineStatic()' !->
    test 'define enumerable and frozen property' !->
        res = defineStatic {}, 'foo', 'bar'
        deepEqual res, { foo: 'bar' }
        throws do
            -> res.foo = 'meh'
            -> true

suite 'defineMeta()' !->
    test 'define hidden and frozen property' !->
        res = defineMeta {}, 'foo', 'bar'
        deepEqual res, {}
        throws do
            -> res.foo = 'meh'
            -> true
