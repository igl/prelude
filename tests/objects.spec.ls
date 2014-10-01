'use strict'

prelude = require '../'

suite 'prelude.objects' !->

    suite 'empty()' !->
        { empty } = prelude.objects

        test 'exists' !->
            expect empty .to.be.a 'function'

        test 'returns correctly on valid inputs' !->
            expect empty {} .to.be true
            expect empty { a: 1 } .to.be false

    suite 'clone()' !->
        { clone } = prelude.objects

        test 'exists' !->
            expect clone .to.be.a 'function'

        test 'returns the same as input' !->
            expect (clone { a: 12 }).a .to.be 12

        test 'returns a copy' !->
            obj = { a:0, b:1, c:2 }
            copy = clone obj
            copy.a = 'foo'
            expect obj.a  .to.be 0
            expect copy.a .to.be 'foo'

    suite 'each()' !->
        { each } = prelude.objects

        test 'exists' !->
            expect each .to.be.a 'function'

        test 'curries' !->
            noop = each!
            expect noop .to.be.a 'function'
            noop = each (->)
            expect noop .to.be.a 'function'
            noop = noop { a:1, b:2, c:3 }
            expect noop .to.be.a 'object'

        test 'iterates over the complete object' !->
            count = 0
            each (-> count += 1), { a:1, b:2, c:3 }
            expect count .to.be 3

        test 'iterator receives key and value' !->
            { a:1, b:2, c:3 } |> each (value, key) ->
                expect value .to.be.a 'number'
                expect key .to.be.a 'string'
                if key is 'a'
                    expect value .to.be 1
                if key is 'b'
                    expect value .to.be 2
                if key is 'c'
                    expect value .to.be 3

    suite 'map()' !->
        { map } = prelude.objects

        test 'exists' !->
            expect map .to.be.a 'function'

        test 'curries' !->
            noop = map
            expect noop .to.be.a 'function'
            noop = map (->)
            expect noop .to.be.a 'function'
            noop = noop { a:1, b:2, c:3 }
            expect noop .to.be.a 'object'

        test 'iterates over the complete object' !->
            count = 0
            map (-> ++count), { a:1, b:2, c:3 }
            expect count .to.be 3

        test 'iterator receives key and value' !->
            { a:0, b:1, c:2 } |> map (value, key) ->
                expect value .to.be.a 'number'
                expect key .to.be.a 'string'
                if key is 'a'
                    expect value .to.be 0
                if key is 'b'
                    expect value .to.be 1
                if key is 'c'
                    expect value .to.be 2

        test 'remap values' !->
            result = map (-> it + 1), { a:0, b:1, c:2 }
            expect result.a .to.be 1
            expect result.b .to.be 2
            expect result.c .to.be 3
            expect result.d .to.be void

    suite 'filter()' !->
        { filter } = prelude.objects

        test 'exists' !->
            expect filter .to.be.a 'function'

        test 'curries' !->
            noop = filter
            expect noop .to.be.a 'function'
            noop = filter (->)
            expect noop .to.be.a 'function'
            noop = noop { a:0, b:1, c:2 }
            expect noop .to.be.a 'object'

        test 'iterates over the complete object' !->
            count = 0
            filter (-> ++count), { a:0, b:1, c:2 }
            expect count .to.be 3

        test 'iterator receives key and value' !->
            { a:0, b:1, c:2 } |> filter (value, key) ->
                expect value .to.be.a 'number'
                expect key .to.be.a 'string'
                if key is 'a'
                    expect value .to.be 0
                if key is 'b'
                    expect value .to.be 1
                if key is 'c'
                    expect value .to.be 2

        test 'filters values' !->
            result = filter (-> typeof it isnt 'string'), { a:0, b:'foo', c:2 }
            expect (Object.keys result)length .to.be 2
            expect result.a .to.be 0
            expect result.c .to.be 2
            expect result.b .to.be void
