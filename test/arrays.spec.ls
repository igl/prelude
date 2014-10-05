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
                expect value .to.be.a 'string'
                expect index .to.be.a 'number'
                if index is 0
                    expect value .to.be 'foo'
                if index is 1
                    expect value .to.be 'bar'
                if index is 2
                    expect value .to.be 'qaz'

        test 'remap values' !->
            result = map (-> it + 1), [0 1 2]
            expect result.0 .to.be 1
            expect result.1 .to.be 2
            expect result.2 .to.be 3
            expect result.3 .to.be void

    suite 'filter()' !->
        { filter } = prelude.arrays

        test 'curries' !->
            noop = filter (->)
            expect noop .to.be.a 'function'
            noop = noop [1 2 3]
            expect noop .to.be.a 'array'

        test 'iterates over the complete array' !->
            count = 0
            filter (-> ++count), [1 2 3]
            expect count .to.be 3

        test 'iterator receives index and value' !->
            ['foo' 'bar' 'qaz'] |> filter (value, index) ->
                expect value .to.be.a 'string'
                expect index .to.be.a 'number'
                if index is 0
                    expect value .to.be 'foo'
                if index is 1
                    expect value .to.be 'bar'
                if index is 2
                    expect value .to.be 'qaz'
                true

        test 'filters values' !->
            result = filter (-> typeof it isnt 'string'), [1 'foo' 2]
            expect result.length .to.be 2
            expect result.0 .to.be 1
            expect result.1 .to.be 2
            expect result.3 .to.be void

    suite 'partition()' !->
        { partition } = prelude.arrays

        test 'curries' !->
            noop = partition (->)
            expect noop .to.be.a 'function'
            noop = noop [1 2 3]
            expect noop .to.be.a 'array'
