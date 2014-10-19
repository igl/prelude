'use strict'

<-! suite 'prelude.funcs'

suite 'Class:' !->

suite 'Class:' !->
    { Class } = prelude.funcs

    Class.staticClassMethod   = (->)

    Person = Class.extend {
        constructor: (firstname, lastname) !->
            this.firstname = firstname
            this.lastname  = lastname
        walk: -> 'walking'
    }

    Employee = Person.extend {
        constructor: (firstname, lastname) !->
            Person.apply this, &
        work: -> 'working'
    }

    Person.staticPersonMethod = (->)
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

        isObject someone
        strictEqual someone.walk!, 'walking'
        strictEqual someone.work!, 'working'
        strictEqual someone.firstname, 'Hans'
        strictEqual someone.lastname,  'Wurst'

