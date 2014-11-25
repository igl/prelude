'use strict'

<-! suite 'prelude.type'

{
    getType, isType, isFunction, isObject, isArray, isString,
    isNumber, isDate, isRegExp, isArguments, isError, isJSON
} = prelude.types

suite 'getType()' !->
    test 'get types' !->
        strictEqual (getType 100       ), 'Number'
        strictEqual (getType ''        ), 'String'
        strictEqual (getType ->        ), 'Function'
        strictEqual (getType []        ), 'Array'
        strictEqual (getType {}        ), 'Object'
        strictEqual (getType &         ), 'Arguments'
        strictEqual (getType new Date  ), 'Date'
        strictEqual (getType new Error ), 'Error'
        strictEqual (getType /foo/     ), 'RegExp'

suite 'isNumber' !->
    test 'truthy' !->
        strictEqual (isNumber 10), true

    test 'falsy' !->
        strictEqual (isNumber ''), false
        strictEqual (isNumber []), false
        strictEqual (isNumber 9e999), false
        strictEqual (isNumber 0 / 0), false

suite 'isString' !->
    test 'truthy' !->
        strictEqual (isString ''), true

    test 'falsy' !->
        strictEqual (isString []), false
        strictEqual (isString 10), false

suite 'isFunction()' !->
    test 'truthy' !->
        strictEqual (isFunction ->), true

    test 'falsy' !->
        strictEqual (isFunction {}), false
        strictEqual (isFunction /x/), false

suite 'isArray' !->
    test 'truthy' !->
        strictEqual (isArray []), true

    test 'falsy' !->
        strictEqual (isArray ''), false
        strictEqual (isArray {}), false

suite 'isObject' !->
    test 'truthy' !->
        strictEqual (isObject {}), true

    test 'falsy' !->
        strictEqual (isObject []), false
        strictEqual (isObject 10), false

suite 'Arguments' !->
    test 'truthy' !->
        strictEqual (isArguments &), true

    test 'falsy' !->
        strictEqual (isArguments []), false
        strictEqual (isArguments {}), false
        strictEqual (isArguments new Date), false

suite 'Date' !->
    test 'truthy' !->
        strictEqual (isDate new Date), true

    test 'falsy' !->
        strictEqual (isDate {}), false
        strictEqual (isDate []), false

suite 'Error' !->
    test 'truthy' !->
        strictEqual (isError new Error 'fail'), true

    test 'falsy' !->
        strictEqual (isError {}), false
        strictEqual (isError {}), false

suite 'RegExp' !->
    test 'truthy' !->
        strictEqual (isRegExp /foo/), true
        strictEqual (isRegExp new RegExp 'foo'), true

    test 'falsy' !->
        strictEqual (isRegExp ''), false
        strictEqual (isRegExp []), false

suite 'JSON' !->
    test 'truthy' !->
        test 'is valid' !->
            deepEqual (isType 'JSON' '{ "a":1 }'), true
            deepEqual (isType 'JSON' '[{ "a":1 }]'), true
            deepEqual (isJSON '[1,2,3]'), true
            deepEqual (isJSON JSON.stringify process.env), true

    test 'falsy' !->
        test 'isnt String' !->
            strictEqual (isType 'JSON' null), false
            strictEqual (isType 'JSON' 0), false
            strictEqual (isType 'JSON' /foo/), false
            strictEqual (isJSON {}), false
        test 'isnt "{}" or "[]"' !->
            strictEqual (isType 'JSON' 'foo'), false
            strictEqual (isType 'JSON' '"a":1'), false
            strictEqual (isType 'JSON' '["a":1'), false
            strictEqual (isJSON '{"a":1'), false
