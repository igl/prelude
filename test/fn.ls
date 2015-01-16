'use strict'

<-! suite 'prelude.func'

{ id, curry, compose, apply, applyTo, applyNew, flip, tryCatch } = prelude.fn

suite 'id()' !->
    test 'returns input argument' !->
        strictEqual (id 1), 1

suite 'curry()' !->
    fn = curry 2 (a, b, c) -> a + b + c
    test 'curries' !->
        isFunction fn 1
        isFunction fn 1, 2
        isNumber   fn 1, 2, 3

suite 'compose()' !->
    addMul = compose do
        -> it * 2
        (a, b) -> a + b

    test 'returns a function' !->
        isFunction addMul

    test 'returns correctly' !->
        strictEqual (addMul 2, 2), 8

suite 'apply()' !->
    test 'apply array as arguments' !->
        fn = (a, b, c) ->
            strictEqual a, 1
            strictEqual b, 2
            strictEqual c, 3
        apply fn, [1 2 3]

suite 'applyTo()' !->
    test 'apply array as arguments with context' !->
        ctx = {}
        fn = (a, b) ->
            this.a = a
            this.b = b
        applyTo ctx, fn, [1 2]
        deepEqual ctx, { a:1, b:2 }

suite 'applyNew()' !->
    test 'apply array as arguments to constructor' !->
        Ctor = (name, age) ->
            this.name = name
            this.age  = age
        deepEqual (applyNew Ctor, ['hans' 24]), { name:'hans', age:24 }

suite 'flip()' !->
    test 'flip arguments' !->
        fn = (a, b) ->
            strictEqual a, 2
            strictEqual b, 1
        (flip fn) 1, 2

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


