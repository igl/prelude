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
        assert.Function Class
        assert.Function Class.extend
        assert.Function Class.staticClassMethod
        assert.Object new Class

    test 'Person extends Class' !->

    test 'Person inherits static properties' !->
        assert.Function Person
        assert.Function Person.extend
        assert.Function Person.staticClassMethod

    test 'Person saves own properties' !->
        someone = new Person 'Hans', 'Wurst'

        assert.Object someone
        assert.strictEqual someone.walk!, 'walking'
        assert.strictEqual someone.firstname, 'Hans'
        assert.strictEqual someone.lastname,  'Wurst'

    test 'Employee extends Person' !->
        someone = new Employee 'Hans', 'Wurst'

        assert.Function Employee
        assert.Function Employee.extend
        assert.Function Employee.staticClassMethod

        assert.Object someone
        assert.strictEqual someone.walk!, 'walking'
        assert.strictEqual someone.work!, 'working'
        assert.strictEqual someone.firstname, 'Hans'
        assert.strictEqual someone.lastname,  'Wurst'

