'use strict'

<-! suite 'func'

{
    id, curry, compose, apply, applyTo, applyNew, flip,
    delay, interval, immediate, tryCatch, chain
} = prelude.func

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

    test 'don\'t curry functions with 0 arguments' !->
        orignalFunc = -> 1 + 1
        fn = curry orignalFunc
        strictEqual fn, orignalFunc
        strictEqual fn!, 2

    test 'don\'t curry functions with 1 argument' !->
        orignalFunc = (a) -> a + 1
        fn = curry orignalFunc
        strictEqual fn, orignalFunc
        strictEqual (fn 1), 2

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
    argLenAsserter = (len) -> ->
        strictEqual &.length, len
        for val, i in &
            strictEqual val, i

    test 'curries' !->
        [0 1 2 3 4] |> apply argLenAsserter

    test 'apply with 0 arguments'  !-> apply (!-> ok true), []
    test 'apply with 1 argument'   !-> apply argLenAsserter(1), [0]
    test 'apply with 2 argument'   !-> apply argLenAsserter(2), [0 1]
    test 'apply with 3 argument'   !-> apply argLenAsserter(3), [0 1 2]
    test 'apply with 4 argument'   !-> apply argLenAsserter(4), [0 1 2 3]
    test 'apply with 5 arguments'  !-> apply argLenAsserter(5), [0 1 2 3 4]
    test 'apply with 6 arguments'  !-> apply argLenAsserter(6), [0 1 2 3 4 5]
    test 'apply with 7 arguments'  !-> apply argLenAsserter(7), [0 1 2 3 4 5 6]
    test 'apply with 8 arguments'  !-> apply argLenAsserter(8), [0 1 2 3 4 5 6 7]
    test 'apply with 9 arguments'  !-> apply argLenAsserter(9), [0 1 2 3 4 5 6 7 8]
    test 'apply with 20 arguments' !-> apply argLenAsserter(20), [0 til 20]
    test 'apply with 100 arguments' !-> apply argLenAsserter(100), [0 til 100]

suite 'applyTo()' !->
    fn0 = !->
    fn1 = (@a) !->
    fn2 = (@a, @b) !->
    fn3 = (@a, @b, @c) !->
    fn4 = (@a, @b, @c, @d) !->
    fn5 = (@a, @b, @c, @d, @e) !->
    fn6 = (@a, @b, @c, @d, @e, @f) !->
    fn7 = (@a, @b, @c, @d, @e, @f, @g) !->
    fn8 = (@a, @b, @c, @d, @e, @f, @g, @h) !->
    fn9 = (@a, @b, @c, @d, @e, @f, @g, @h, @i) !->
    fn10 = (@a, @b, @c, @d, @e, @f, @g, @h, @i, @j) !->

    test 'applyTo with 0 arguments' !->
        ctx = {}
        applyTo ctx, fn0, []
        deepEqual ctx, {}

    test 'applyTo with 1 argument' !->
        ctx = {}
        applyTo ctx, fn1, [0]
        deepEqual ctx, { a:0 }

    test 'applyTo with 2 argument' !->
        ctx = {}
        applyTo ctx, fn2, [0 1]
        deepEqual ctx, { a:0 b:1 }

    test 'applyTo with 3 argument' !->
        ctx = {}
        applyTo ctx, fn3, [0 1 2]
        deepEqual ctx, { a:0 b:1 c:2 }

    test 'applyTo with 4 arguments' !->
        ctx = {}
        applyTo ctx, fn4, [0 1 2 3]
        deepEqual ctx, { a:0 b:1 c:2 d:3 }

    test 'applyTo with 5 arguments' !->
        ctx = {}
        applyTo ctx, fn5, [0 1 2 3 4]
        deepEqual ctx, { a:0 b:1 c:2 d:3 e:4 }

    test 'applyTo with 6 arguments' !->
        ctx = {}
        applyTo ctx, fn6, [0 1 2 3 4 5]
        deepEqual ctx, { a:0 b:1 c:2 d:3 e:4 f:5 }

    test 'applyTo with 7 arguments' !->
        ctx = {}
        applyTo ctx, fn7, [0 1 2 3 4 5 6]
        deepEqual ctx, { a:0 b:1 c:2 d:3 e:4 f:5 g:6 }

    test 'applyTo with 8 arguments' !->
        ctx = {}
        applyTo ctx, fn8, [0 1 2 3 4 5 6 7]
        deepEqual ctx, { a:0 b:1 c:2 d:3 e:4 f:5 g:6 h:7 }

    test 'applyTo with 9 arguments' !->
        ctx = {}
        applyTo ctx, fn9, [0 1 2 3 4 5 6 7 8]
        deepEqual ctx, { a:0 b:1 c:2 d:3 e:4 f:5 g:6 h:7 i:8 }

    test 'applyTo with 10 arguments' !->
        ctx = {}
        applyTo ctx, fn10, [0 1 2 3 4 5 6 7 8 9]
        deepEqual ctx, { a:0 b:1 c:2 d:3 e:4 f:5 g:6 h:7 i:8 j:9 }

suite 'applyNew()' !->
    fn0 = !->
    fn1 = (@a) !->
    fn2 = (@a, @b) !->
    fn3 = (@a, @b, @c) !->
    fn4 = (@a, @b, @c, @d) !->
    fn5 = (@a, @b, @c, @d, @e) !->
    fn6 = (@a, @b, @c, @d, @e, @f) !->
    fn7 = (@a, @b, @c, @d, @e, @f, @g) !->
    fn8 = (@a, @b, @c, @d, @e, @f, @g, @h) !->
    fn9 = (@a, @b, @c, @d, @e, @f, @g, @h, @i) !->
    fn10 = (@a, @b, @c, @d, @e, @f, @g, @h, @i, @j) !->

    test 'applyNew with 0 arguments' !->
        deepEqual (applyNew fn0, []), {}

    test 'applyNew with 1 argument' !->
        deepEqual (applyNew fn1, [0]), { a:0 }

    test 'applyNew with 2 argument' !->
        deepEqual (applyNew fn2, [0 1]), { a:0 b:1 }

    test 'applyNew with 3 arguments' !->
        deepEqual (applyNew fn3, [0 1 2]), { a:0 b:1 c:2 }

    test 'applyNew with 4 arguments' !->
        deepEqual (applyNew fn4, [0 1 2 3]), { a:0 b:1 c:2 d:3 }

    test 'applyNew with 5 arguments' !->
        deepEqual (applyNew fn5, [0 1 2 3 4]), { a:0 b:1 c:2 d:3 e:4 }

    test 'applyNew with 6 arguments' !->
        deepEqual (applyNew fn6, [0 1 2 3 4 5]), { a:0 b:1 c:2 d:3 e:4 f:5 }

    test 'applyNew with 7 arguments' !->
        deepEqual (applyNew fn7, [0 1 2 3 4 5 6]), { a:0 b:1 c:2 d:3 e:4 f:5 g:6 }

    test 'applyNew with 8 arguments' !->
        deepEqual (applyNew fn8, [0 1 2 3 4 5 6 7]), { a:0 b:1 c:2 d:3 e:4 f:5 g:6 h:7 }

    test 'applyNew with 9 arguments' !->
        deepEqual (applyNew fn9, [0 1 2 3 4 5 6 7 8]), { a:0 b:1 c:2 d:3 e:4 f:5 g:6 h:7 i:8 }

    test 'applyNew with 10 arguments' !->
        deepEqual (applyNew fn10, [0 1 2 3 4 5 6 7 8 9]), { a:0 b:1 c:2 d:3 e:4 f:5 g:6 h:7 i:8 j:9 }

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
            ok (time >= 50 and time <= 60), 'is between 50 - 60ms'
            done!

suite 'interval()' !->
    test 'interval 10ms' (done) !->
        retry = 3
        s = Date.now!
        interval 10, ->
            time = Date.now! - s
            ok (time >= 10 and time <= 20), "#time is not between 10 - 20ms"

            # reset time for next interval
            s := Date.now!
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
    err = new Error 'Error!'

    test 'return caught error' !->
        deepEqual (tryCatch !-> throw err), err

    test 'return value' !->
        strictEqual (tryCatch -> 10), 10

    test 'catch non-errors and always create errors' !->
        isError (tryCatch !-> throw "foo")

    test 'catch error in callback' (done) !->
        tryCatch do
            !-> throw err
            (err) !->
                isError err
                done!

suite 'chain()' !->
    test 'chains thru all supplied functions' (done) !->
        chain do
            (next) -> (ok true); next!
            (next) -> (ok true); next!
            (next) -> (ok true); next!
            (err)  -> (ok true); done!

    test 'catches thrown errors' (done) !->
        chain do
            (next) -> next!
            (next) -> throw new Error 'thrown'
            (next) -> throw new Error 'This should not be called!'
            (err) ->
                strictEqual err.message, 'thrown'
                done!

    test '1st double called back returns an error' (done) !->
        chain do
            (next) -> next!; next!
            (next) -> next!
            (next) -> next!
            (err) ->
                strictEqual err.message, 'callback[1] is called twice!'
                done!

    test '2nd double called back returns an error' (done) !->
        chain do
            (next) -> next!
            (next) -> next!; next!
            (next) -> next!
            (err) ->
                strictEqual err.message, 'callback[2] is called twice!'
                done!
    test '3rd double called back returns an error' (done) !->
        chain do
            (next) -> next!
            (next) -> next!
            (next) -> next!; next!
            (err) ->
                strictEqual err.message, 'callback[3] is called twice!'
                done!

    test 'do not pass arguments if next function does not define them' (done) !->
        chain do
            (next) ->
                next void, 1, 2, 3

            (a, b, c, next) ->
                strictEqual a, 1
                strictEqual b, 2
                strictEqual c, 3
                next void, a, b, c

            (a, b, next) ->
                strictEqual a, 1
                strictEqual b, 2
                next void, a, b, 3

            (a, next) ->
                strictEqual a, 1
                next void, a, 2, 3

            (err, a)  ->
                strictEqual a, 1
                done err
