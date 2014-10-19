'use strict'

prelude = require '../'

suite 'prelude.arrays' !->

    suite 'empty()' !->
        { empty } = prelude.arrays

        test 'returns correctly with valid inputs' !->
            strictEqual (empty []), true
            strictEqual (empty [1]), false

    suite 'clone()' !->
        { clone } = prelude.arrays

        test 'returns the same as input' !->
            deepEqual do
                (clone [1 2 3])
                [1 2 3]

        test 'returns a copy' !->
            original = [1 2 3 4 5]
            copy     = clone original
            copy.2   = 'foo'

            strictEqual original.2, 3
            strictEqual copy.2, 'foo'

    suite 'each()' !->
        { each } = prelude.arrays

        test 'curries' !->
            isFunction each (->)
            isArray each (->), [1 2 3]

        test 'iterates over the complete array' !->
            count = 0
            each (-> count += 1), [1 2 3 4]
            strictEqual count, 4

        test 'iterator receives index and value' !->
            ['foo' 'bar' 'qaz'] |> each (value, index) ->
                isString value
                isNumber index
                if index is 0 then strictEqual value, 'foo'
                if index is 1 then strictEqual value, 'bar'
                if index is 2 then strictEqual value, 'qaz'

    suite 'map()' !->
        { map } = prelude.arrays

        test 'curries' !->
            isFunction map (->)
            isArray map (->), [1 2 3]

        test 'iterates over the complete array' !->
            count = 0
            map (-> ++count), [1 2 3]
            strictEqual count, 3

        test 'iterator receives index and value' !->
            ['foo' 'bar' 'qaz'] |> map (value, index) ->
                isString value
                isNumber index
                if index is 0 then strictEqual value, 'foo'
                if index is 1 then strictEqual value, 'bar'
                if index is 2 then strictEqual value, 'qaz'

        test 'remap values' !->
            deepEqual do
                [0 1 2] |> map (-> it + 1)
                [1 2 3]

    suite 'filter()' !->
        { filter } = prelude.arrays

        test 'curries' !->
            isFunction filter (->)
            isArray    filter (->), [1 2 3]

        test 'iterates over the complete array' !->
            count = 0
            filter (-> ++count), [1 2 3]
            strictEqual count, 3

        test 'iterator receives index and value' !->
            ['foo' 'bar' 'qaz'] |> filter (value, index) ->
                isString value
                isNumber index
                if index is 0 then strictEqual value, 'foo'
                if index is 1 then strictEqual value, 'bar'
                if index is 2 then strictEqual value, 'qaz'

        test 'filters values' !->
            deepEqual do
                filter (-> typeof it isnt 'string'), [1 'foo' 2]
                [1 2]

    suite 'zip()' !->
        { zip } = prelude.arrays

        test 'zips array' ->
            deepEqual do
                zip [1 2] [3 4]
                [[1 3], [2 4]]

        test 'zip with uneven array length (1)' ->
            deepEqual do
                zip [1 2 9] [3 4]
                [[1 3], [2 4]]

        test 'zip with uneven array length (2)' ->
            deepEqual do
                zip [1 2] [3 4 9]
                [[1 3], [2 4]]

    suite 'zipWith()' !->
        { zipWith } = prelude.arrays

        test 'curries' !->
            isFunction zipWith (->)
            isFunction zipWith (->), [1 2 3]
            isArray    zipWith (->), [1 2 3] [1 2 3]

        test 'zips array' ->
            deepEqual do
                zipWith (-> &0 + &1), [1 2] [3 4]
                [4 6]

        test 'zips multible arrays' ->
            deepEqual do
                zipWith (-> &0 + &1 + &2), [1 2] [2 1] [10 20]
                [13 23]

        test 'zip with uneven array length (1)' ->
            deepEqual do
                zipWith (-> &0 + &1), [1 2 9] [3 4]
                [4 6]

        test 'zip with uneven array length (2)' ->
            deepEqual do
                zipWith (-> &0 + &1), [1 2] [3 4 9]
                [4 6]

    suite 'partition()' !->
        { partition } = prelude.arrays

        test 'curries' !->
            isFunction partition (->)
            isArray    partition (->), [1 2 3]

        test 'partitions array' !->
            deepEqual do
                partition (-> it is 2), [1 2 3 4]
                [[2], [1 3 4]]
