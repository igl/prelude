'use strict'

<-! suite 'prelude'


prelude = require '../'

suite 'modules' !->
    test 'exports all modules' !->
        ok prelude.array
        ok prelude.object
        ok prelude.string
        ok prelude.type
        ok prelude.number

suite 'importAll' !->
    test 'exports all functions into a given object' !->
        myGlobal = {}
        prelude.import-all myGlobal

        isFunction myGlobal.array-each
        isFunction myGlobal.fn-curry
        isFunction myGlobal.number-even
        isFunction myGlobal.object-mixin
        isFunction myGlobal.string-capitalize
        isFunction myGlobal.type-is-string
