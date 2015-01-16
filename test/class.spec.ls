'use strict'

{ Class } = prelude

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
