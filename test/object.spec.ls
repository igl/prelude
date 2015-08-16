'use strict'

<-! suite 'object'

{
    empty, has, includes, keys, values, clone, flatten, explode,
    each, map, filter, every, some, partition, keyOf, keysOf,
    findKey, findKeys, fromPairs, toPairs,
    fill, deepFill, assign, deepAssign, merge, deepMerge,
    freeze, deepFreeze, toJSON, fromJSON,
    definePublic, definePrivate, defineStatic, defineMeta
} = prelude.object

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

suite 'includes()' !->
    test 'does contain a value' !->
        strictEqual do
            includes 2, { a:1, b:2, c:3 }
            true

    test 'does not contain a value' !->
        strictEqual do
            includes 'foo', { a:1, b:2, c:3 }
            false

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

suite 'flatten()' !->
    test 'returns a copy of input' !->
        arg = { a: 10 }
        deepEqual do
            flatten null, arg
            arg
        ok (flatten null, arg) isnt arg

    test 'flatten with empty delimiter string' !->
        deepEqual do
            flatten '', { a: 10, b: { c: 20 } }
            { a: 10, bc: 20 }

    test 'flatten without delimiter' !->
        deepEqual do
            flatten null, { a: 10, b: { c: 20 } }
            { a: 10, c: 20 }

    test 'flatten without delimiter 3D' !->
        deepEqual do
            flatten null, {
                a: 10
                b:
                    c: 20
                    d: 30
                    e:
                        f: 40
                        g: 50
                        h: {
                            i: 60
                            j: 70
                        }
            }
            {
                a: 10
                c: 20
                d: 30
                f: 40
                g: 50
                i: 60
                j: 70
            }

    test 'flatten with delimiter 3D' !->
        deepEqual do
            flatten '_', {
                a: 10
                b:
                    c: 20
                    d: 30
                    e:
                        f: 40
                        g: 50
                        h: {
                            i: 60
                            j: 70
                        }
            }
            {
                a: 10
                b_c: 20
                b_d: 30
                b_e_f: 40
                b_e_g: 50
                b_e_h_i: 60
                b_e_h_j: 70
            }

suite 'explode()' !->
    test 'returns a copy of input' !->
        arg = { a: 10 }
        deepEqual do
            explode null, arg
            arg
        ok (explode null, arg) isnt arg

    test 'explode with delimiter' !->
        deepEqual do
            explode '_', { a: 10, b_c: 20 }
            { a: 10, b:c: 20 }


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

suite 'every()' !->
    test 'iterates over all keys' !->
        count = 0
        strictEqual do
            { a:1, b:2, c:3 } |> every -> ++count; true
            true
        strictEqual count, 3, 'did not iterate over all keys'

    test 'iterates until miss' !->
        count = 0
        strictEqual do
            { a:1, b:2, c:3, d:4, e:5 } |> every -> ++count; it < 3
            false
        strictEqual count, 3, "iterator was called too often (#count)"

suite 'some()' !->
    test 'iterates over all keys' !->
        count = 0
        deepEqual do
            { a:1, b:2, c:3 } |> some -> count++; false
            false

    test 'iterates until found' !->
        count = 0
        strictEqual do
            { a:1, b:2, c:3, d:4, e:5 } |> some -> ++count; it > 2
            true
        strictEqual count, 3, "iterator was called too often (#count)"

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

suite 'assign()' !->
    test 'curries' !->
        deepEqual do
            { b:2 } |> assign { a:1 }
            { a:1, b:2 }

    test 'add to object' !->
        deepEqual do
            assign { a:1 }, { b:2 }
            { a:1, b:2 }

    test 'add to new object' !->
        deepEqual do
            assign null, { a:1 }, { b:2 }
            { a:1, b:2 }

suite 'deepAssign()' !->
    test 'curries' !->
        deepEqual do
            { b:{ d:3 }} |> deepAssign { a:1, b:{ c:2 }}
            { a:1, b:{ c:2, d:3 }}

    test 'adds to object' !->
        deepEqual do
            deepAssign { a:1, b:{ c:2 }}, { b:{ d:3 }}
            { a:1 b:{ c:2, d:3 }}

    test 'adds to new object' !->
        deepEqual do
            deepAssign null, { a:1, b:{ c:2 }}, { b:{ d:3 }}
            { a:1 b:{ c:2, d:3 }}

suite 'merge()' !->
    test 'curries' !->
        deepEqual do
            { b:2 } |> merge { a:1 }
            { a:1, b:2 }

    test 'adds to object' !->
        deepEqual do
            merge { a:1 }, { b:2 }
            { a:1, b:2 }

    test 'returns a new object' !->
        original = { a:1, b:2 }
        result   = merge original, { c:3 }

        deepEqual result, { a:1, b:2, c:3 }
        result.d = 4
        deepEqual result, { a:1, b:2, c:3, d:4 }
        deepEqual original, { a:1, b:2 }

suite 'deepMerge()' !->
    test 'curries' !->
        deepEqual do
            { b:2 } |> deepMerge { a:1 }
            { a:1, b:2 }

    test 'adds to object' !->
        deepEqual do
            deepMerge { a:1 c:{ x:3 }}, { b:2 }, { c: { y:4 }}
            { a:1, b:2, c:{ x:3, y:4 }}

    test 'makes a deep copy' !->
        original = { a:1, b:2, c:{ x:3, y:4 }}
        result   = deepMerge original, { c:x:0 }

        deepEqual result, { a:1, b:2, c:{ x:0, y:4 }}
        result.c.y = 0
        deepEqual result, { a:1, b:2, c:{ x:0, y:0 }}
        deepEqual original, { a:1, b:2, c:{ x:3, y:4 }}

    test 'makes a deep copy even within arrays' !->
        original = { a:1, b:2, c:[{ d:3 }]}
        result   = deepMerge original, { e:4 }

        deepEqual result, { a:1, b:2, c:[{ d:3 }], e:4}
        result.c.push 11
        result.c.0.d += 1

        deepEqual result.c, [{ d:4 }, 11]
        deepEqual original.c, [{ d:3 }]

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

suite 'toJSON()' !->
    test 'convert object to string without indentBy' !->
        strictEqual do
            toJSON { a:1, b:c:2 }
            '''{"a":1,"b":{"c":2}}'''

    test 'convert object to string with indentBy set to 2' !->
        strictEqual do
            toJSON { a:1, b:c:2 }, 2
            '''{
              "a": 1,
              "b": {
                "c": 2
              }
            }'''

    test 'convert object to string with indentBy set to 4' !->
        strictEqual do
            toJSON { a:1, b:c:2 }, 4
            '''{
                "a": 1,
                "b": {
                    "c": 2
                }
            }'''

suite 'fromJSON()' !->
    test 'convert string to object' !->
        deepEqual do
            fromJSON '{"a":1,"b":{"c":2}}'
            { a:1, b:{ c:2 }}

suite 'definePublic()' !->
    test 'curries' !->
        init = { a:1 }
        deepEqual do
            (definePublic init) 'b', 2
            { a:1 b:2 }

    test 'define enumerable property' !->
        deepEqual do
            definePublic {}, 'a', 1
            { a:1 }

    test 'define multiple enumerable properties' !->
        deepEqual do
            definePublic {}, { a:1, b:2 }
            { a:1, b:2 }

suite 'definePrivate()' !->
    test 'curries' !->
        init = { a:1 }
        res  = (definePrivate init) 'b', 2

        deepEqual res, { a:1 }
        strictEqual res.b, 2

    test 'define hidden property' !->
        res = definePrivate {}, 'a', 1
        deepEqual res, {}
        strictEqual res.a, 1

    test 'define multiple hidden properties' !->
        res = definePrivate {}, { a:1 b:2 }
        deepEqual res, {}
        strictEqual res.a, 1
        strictEqual res.b, 2

suite 'defineStatic()' !->
    test 'curries' !->
        init = { a:1 }
        res  = (defineStatic init) 'b', 2

        deepEqual res, { a:1 b:2 }
        throws do
            -> res.b = 3
            -> true

    test 'define enumerable and frozen property' !->
        res = defineStatic {}, 'a', 1

        deepEqual res, { a:1 }
        throws do
            -> res.a = 2
            -> true

    test 'define multiple enumerable and frozen properties' !->
        res = defineStatic {}, { a:1 b:2 }

        deepEqual res, { a:1 b:2 }
        throws do
            -> res.a = 3
            -> true
        throws do
            -> res.b = 3
            -> true

suite 'defineMeta()' !->
    test 'curries' !->
        init = { a:1 }
        res  = (defineMeta init) 'b', 2

        deepEqual res, { a:1 }
        strictEqual res.b, 2
        throws do
            -> res.b = 3
            -> true

    test 'define hidden and frozen property' !->
        res = defineMeta {}, 'a', 1

        deepEqual res, {}
        throws do
            -> res.a = 2
            -> true

    test 'define multiple hidden and frozen properties' !->
        res = defineMeta {}, { a:1 b:2 }

        deepEqual res, {}
        throws do
            -> res.a = 3
            -> true
        throws do
            -> res.b = 3
            -> true
