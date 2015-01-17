'use strict'

<-! suite 'prelude.func'

{
    id, curry, compose, apply, applyTo, applyNew, flip,
    delay, interval, immediate, tryCatch
} = prelude.fn

suite 'id()' !->
    test 'returns input argument' !->
        strictEqual (id 1), 1

suite 'curry()' !->
    test 'curries' !->
        fn = curry 2 (a, b, c) -> a + b + c
        isFunction fn!
        isFunction fn 1
        isFunction fn 1, 2
        strictEqual (fn 1, 2, 3), 6

    test 'don\'t curry on 1 argument' !->
        fn = curry (a) -> a + 2
        strictEqual (fn 2), 4

    test 'get argument length automatically (short)' !->
        fn = curry (a, b) -> a + b
        isFunction fn!
        isFunction fn 2
        strictEqual (fn 2, 2), 4

    test 'get argument length automatically (long)' !->
        fn = curry (a, b, c, d) -> a + b + c + d
        isFunction fn!
        isFunction fn 1,
        isFunction fn 1, 1
        isFunction fn 1, 1, 1
        strictEqual (fn 1, 1, 1, 1), 4

suite 'compose()' !->
    addMul = compose do
        -> it * 2
        (a, b) -> a + b

    test 'returns a function' !->
        isFunction addMul

    test 'returns correctly' !->
        strictEqual (addMul 2, 2), 8

suite 'apply()' !->
    fn1 = (a) !->
        strictEqual a, 0
    fn3 = (a, b, c) !->
        strictEqual a, 0
        strictEqual b, 1
        strictEqual c, 2
    fn10 = (a, b, c, d, e, f, g, h, i, j) !->
        strictEqual a, 0
        strictEqual b, 1
        strictEqual c, 2
        strictEqual d, 3
        strictEqual e, 4
        strictEqual f, 5
        strictEqual g, 6
        strictEqual h, 7
        strictEqual i, 8
        strictEqual j, 9

    test 'curries' !->
        [0 1 2] |> apply fn3

    test 'apply array as arguments (1)' !->
        apply fn1, [0]

    test 'apply array as arguments (3)' !->
        apply fn3, [0 1 2]

    test 'apply array as arguments (10)' !->
        apply fn10, [0 1 2 3 4 5 6 7 8 9]

suite 'applyTo()' !->
    fn1 = (@a) !->
    fn3 = (@a, @b, @c) !->
    fn10 = (@a, @b, @c, @d, @e, @f, @g, @h, @i, @j) !->

    test 'apply array as arguments with context 1' !->
        ctx = {}
        applyTo ctx, fn1, [0]
        deepEqual ctx, { a:0 }

    test 'apply array as arguments with context 2' !->
        ctx = {}
        applyTo ctx, fn3, [0 1 2]
        deepEqual ctx, { a:0, b:1, c:2 }

    test 'apply array as arguments with context 3' !->
        ctx = {}
        applyTo ctx, fn10, [0 1 2 3 4 5 6 7 8 9]
        deepEqual ctx, { a:0, b:1, c:2, d:3, e:4, f:5, g:6, h:7, i:8, j:9 }

suite 'applyNew()' !->
    test 'apply array as arguments to constructor' !->
        Ctor = (name, age) !->
            this.name = name
            this.age  = age
        deepEqual do
            applyNew Ctor, ['hans' 24]
            { name:'hans', age:24 }

suite 'flip()' !->
    test 'flip arguments' !->
        fn = (a, b) ->
            strictEqual a, 2
            strictEqual b, 1
            a + b

        isFunction flip fn
        strictEqual ((flip fn) 1, 2), 3

suite 'delay()' !->
    test 'delay 50ms' (done) !->
        s = Date.now!
        delay 50, !->
            time = Date.now! - s
            ok (time >= 50 and time <= 52), 'is between 50 - 52ms'
            done!

suite 'interval()' !->
    test 'interval 10ms' (done) !->
        retry = 3
        s = Date.now!
        interval 10, ->
            time = Date.now! - s
            s := Date.now!
            ok (time >= 10 and time <= 12), 'is between 10 - 12ms'

            if --retry is 0
                done!
                false
            else
                true

suite 'immediate()' !->
    test 'immediate calls immediatly' (done) !->
        s = Date.now!
        immediate !->
            ok (Date.now! - s <= 1), 'called immediatly'
            done!

suite 'tryCatch()' !->
    e = new Error 'Error!'
    test 'catch and return error' !->
        deepEqual (tryCatch !-> throw e), e

    test 'catch error in callback' (done) !->
        tryCatch do
            !-> throw e
            (err) !->
                isError err
                done!
