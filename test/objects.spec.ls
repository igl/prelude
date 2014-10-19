'use strict'

prelude = require '../'

suite 'prelude.objects' !->

    suite 'empty()' !->
        { empty } = prelude.objects

        test 'returns correctly with valid inputs' !->
            strictEqual (empty {}), true
            strictEqual (empty { a: 1 }), false

    suite 'clone()' !->
        { clone } = prelude.objects

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
        { each } = prelude.objects

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
        { map } = prelude.objects

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
        { filter } = prelude.objects

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
