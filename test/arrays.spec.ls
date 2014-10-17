'use strict'

prelude = require '../'

suite 'prelude.arrays' !->

    suite 'empty()' !->
        { empty } = prelude.arrays

        test 'returns correctly with valid inputs' !->
            expect empty [] .to.be true
            expect empty [1] .to.be false

    suite 'clone()' !->
        { clone } = prelude.arrays

        test 'returns the same as input' !->
            expect (clone [1 2 3])0 .to.be 1
            expect (clone [1 2 3])1 .to.be 2
            expect (clone [1 2 3])2 .to.be 3
            expect (clone [1 2 3])3 .to.be void

        test 'returns a copy' !->
            xs = [1 2 3 4 5]
            copy = clone xs
            copy.2 = 'foo'
            expect xs.2 .to.be 3
            expect copy.2 .to.be 'foo'

    suite 'each()' !->
        { each } = prelude.arrays

        test 'curries' !->
            noop = each (->)
            expect noop .to.be.a 'function'
            noop = noop [1 2 3]
            expect noop .to.be.a 'array'

        test 'iterates over the complete array' !->
            count = 0
            each (-> count += 1), [1 2 3 4]
            expect count .to.be 4

        test 'iterator receives index and value' !->
            ['foo' 'bar' 'qaz'] |> each (value, index) ->
                expect value .to.be.a 'string'
                expect index .to.be.a 'number'
                if index is 0
                    expect value .to.be 'foo'
                if index is 1
                    expect value .to.be 'bar'
                if index is 2
                    expect value .to.be 'qaz'

    suite 'map()' !->
        { map } = prelude.arrays

        test 'curries' !->
            noop = map (->)
            expect noop .to.be.a 'function'
            noop = noop [1 2 3]
            expect noop .to.be.a 'array'

        test 'iterates over the complete array' !->
            count = 0
            map (-> ++count), [1 2 3]
            expect count .to.be 3

        test 'iterator receives index and value' !->
            ['foo' 'bar' 'qaz'] |> map (value, index) ->
                assert.String value
                assert.Number index
                if index is 0 then assert.strictEqual 'foo' value
                if index is 1 then assert.strictEqual 'bar' value
                if index is 2 then assert.strictEqual 'qaz' value

        test 'remap values' !->
            assert.deepEqual do
                [0 1 2] |> map (-> it + 1)
                [1 2 3]

    suite 'filter()' !->
        { filter } = prelude.arrays

        test 'curries' !->
            assert.Function filter (->)
            assert.Array    filter (->), [1 2 3]

        test 'iterates over the complete array' !->
            count = 0
            filter (-> ++count), [1 2 3]
            assert.strictEqual 3 count

        test 'iterator receives index and value' !->
            ['foo' 'bar' 'qaz'] |> filter (value, index) ->
                assert.String value
                assert.Number index
                if index is 0 then assert.strictEqual 'foo' value
                if index is 1 then assert.strictEqual 'bar' value
                if index is 2 then assert.strictEqual 'qaz' value

        test 'filters values' !->
            assert.deepEqual do
                filter (-> typeof it isnt 'string'), [1 'foo' 2]
                [1 2]

    suite 'zip()' !->
        { zip } = prelude.arrays

        test 'zips array' ->
            assert.deepEqual do
                zip [1 2] [3 4]
                [[1 3], [2 4]]

        test 'zip with uneven array length (1)' ->
            assert.deepEqual do
                zip [1 2 9] [3 4]
                [[1 3], [2 4]]

        test 'zip with uneven array length (2)' ->
            assert.deepEqual do
                zip [1 2] [3 4 9]
                [[1 3], [2 4]]

    suite 'zipWith()' !->
        { zipWith } = prelude.arrays

        test 'curries' !->
            assert.Function zipWith (->)
            assert.Function zipWith (->), [1 2 3]
            assert.Array    zipWith (->), [1 2 3] [1 2 3]

        test 'zips array' ->
            assert.deepEqual do
                zipWith (-> &0 + &1), [1 2] [3 4]
                [4 6]

        test 'zips multible arrays' ->
            assert.deepEqual do
                zipWith (-> &0 + &1 + &2), [1 2] [2 1] [10 20]
                [13 23]

        test 'zip with uneven array length (1)' ->
            assert.deepEqual do
                zipWith (-> &0 + &1), [1 2 9] [3 4]
                [4 6]

        test 'zip with uneven array length (2)' ->
            assert.deepEqual do
                zipWith (-> &0 + &1), [1 2] [3 4 9]
                [4 6]

    suite 'partition()' !->
        { partition } = prelude.arrays

        test 'curries' !->
            assert.Function partition (->)
            assert.Array    partition (->), [1 2 3]

        test 'partitions array' !->
            assert.deepEqual do
                partition (-> it is 2), [1 2 3 4]
                [[2], [1 3 4]]
