'use strict'

<-! suite 'prelude.func'

{ noop, curry, apply, applyTo, applyNew, flip, chain, tryCatch, Class } = prelude.funcs

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
        Ctor = (a, b) ->
            this.a = a
            this.b = b
        deepEqual (applyNew Ctor, [1 2]), { a:1, b:2 }

suite 'flip()' !->
    test 'flip arguments' !->
        fn = (a, b) ->
            strictEqual a, 2
            strictEqual b, 1
        (flip fn) 1, 2

suite 'Class:' !->

    Class.staticClassMethod   = (->)

    Person = Class.extend {
        constructor: (firstname, lastname) !->
            this.firstname = firstname
            this.lastname  = lastname
        walk: -> 'walking'
    }

    Person.staticPersonMethod = (->)

    Employee = Person.extend {
        constructor: (firstname, lastname) !->
            Person.apply this, &
        work: -> 'working'
    }

    Employee.staticEmployeeMethod = (->)

    test 'Class inherits static properties' !->
        isFunction Class
        isFunction Class.extend
        isFunction Class.staticClassMethod
        isObject new Class

    test 'Person extends Class' !->

    test 'Person inherits static properties' !->
        isFunction Person
        isFunction Person.extend
        isFunction Person.staticClassMethod
        isFunction Person.staticPersonMethod

    test 'Person saves own properties' !->
        someone = new Person 'Hans', 'Wurst'

        isObject someone
        strictEqual someone.walk!, 'walking'
        strictEqual someone.firstname, 'Hans'
        strictEqual someone.lastname,  'Wurst'

    test 'Employee extends Person' !->
        someone = new Employee 'Hans', 'Wurst'

        isFunction Employee
        isFunction Employee.extend
        isFunction Employee.staticClassMethod
        isFunction Employee.staticPersonMethod
        isFunction Employee.staticEmployeeMethod

        isObject someone
        strictEqual someone.walk!, 'walking'
        strictEqual someone.work!, 'working'
        strictEqual someone.firstname, 'Hans'
        strictEqual someone.lastname,  'Wurst'
