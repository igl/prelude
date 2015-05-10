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
