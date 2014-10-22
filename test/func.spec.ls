'use strict'

<-! suite 'prelude.func'

{ noop, curry, apply, applyTo, applyNew, flip, chain, concurrent, tryCatch, Class } = prelude.funcs

suite 'noop()' !->
    test 'returns input argument' !->
        strictEqual (noop 1), 1

suite 'curry()' !->
    fn = curry 3 (a, b, c) -> a + b + c
    test 'curries' !->
        isFunction fn 1
        isFunction fn 1, 2
        isNumber   fn 1, 2, 3

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

suite 'chain()' !->
    test 'passes arguments through the chain' !->
        chain do
            (next)       !-> next null, 1
            (prev, next) !-> next null, ++prev
            (prev, next) !-> next null, ++prev
            (err, res)   !->
                ok (not err)
                strictEqual res, 3

    test 'stops on generated error' !->
        chain do
            (next) !-> next!
            (next) !-> next (new Error 'Stop')
            (next) !-> ok false, 'Should not execute'
            (err, res) !->
                isError err
                ok not res

    test 'stops on thrown error' !->
        chain do
            (next) !-> next!
            (next) !-> throw new Error 'Stop'
            (next) !-> ok false, 'Should not execute'
            (err, res) !->
                isError err
                ok not res

suite 'concurrent()' !->
    e = new Error 'Error!'
    test 'collects errors and arguments' !->
        concurrent do
            (next) !-> next e
            (next) !-> next null, 1
            (next) !-> next null, 2
            (next) !-> next null, 3
            (errors, results) !->
                deepEqual errors, [e, void, void]
                deepEqual results, [void, 1, 2, 3]

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

suite 'Class:' !->

    Class.staticClassMethod   = (->)

    Person = Class.extend {
        constructor: (firstname, lastname) !->
            this.firstname = firstname
            this.lastname  = lastname
            Class.apply this
            return
        walk: -> 'walking'
    }

    Person.staticPersonMethod = (->)

    Employee = Person.extend {
        constructor: (firstname, lastname) !->
            Person.apply this, &
        initialize: ->
            this.ready = true
        work: -> 'working'
    }

    Employee.staticEmployeeMethod = (->)

    Foo = Class.extend {
        initialize: ->
            this.ready = true
    }

    Bar = Class.extend { isReady: -> true }


    test 'Class has static properties' !->
        isFunction Class
        isFunction Class.extend

    test 'Class is newable' !->
        isObject new Class

    test 'Foo inherits from Class' !->
        isFunction Foo
        isFunction Foo.extend

    test 'Foo is newable without constructor' !->
        foo = new Foo
        isObject foo
        strictEqual foo.ready, true

    test 'Bar is newable without constructor and initialize' !->
        bar = new Bar
        isObject bar
        strictEqual bar.isReady(), true

    test 'Person has methods' !->
        person = new Person 'Hans', 'Wurst'
        isObject person
        strictEqual person.walk!, 'walking'

    test 'Person initialize & constructor is called' !->
        person = new Person 'Hans', 'Wurst'
        strictEqual person.firstname, 'Hans'
        strictEqual person.lastname,  'Wurst'

    test 'Employee extends Person' !->
        employee = new Employee 'Hans', 'Wurst'
        isFunction Employee
        isFunction Person.extend
        isFunction Employee.staticPersonMethod
        strictEqual employee.ready, true
