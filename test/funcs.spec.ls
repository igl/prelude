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
        equalsFunction Class
        equalsFunction Class.extend
        equalsFunction Class.staticClassMethod
        equalsObject new Class

    test 'Person extends Class' !->

    test 'Person inherits static properties' !->
        equalsFunction Person
        equalsFunction Person.extend
        equalsFunction Person.staticClassMethod

    test 'Person saves own properties' !->
        someone = new Person 'Hans', 'Wurst'

        equalsObject someone
        strictEqual someone.walk!, 'walking'
        strictEqual someone.firstname, 'Hans'
        strictEqual someone.lastname,  'Wurst'

    test 'Employee extends Person' !->
        someone = new Employee 'Hans', 'Wurst'

        equalsFunction Employee
        equalsFunction Employee.extend
        equalsFunction Employee.staticClassMethod

        equalsObject someone
        strictEqual someone.walk!, 'walking'
        strictEqual someone.work!, 'working'
        strictEqual someone.firstname, 'Hans'
        strictEqual someone.lastname,  'Wurst'

