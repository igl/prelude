'use strict'

<-! suite 'prelude.type'

{
    getType, isNumber, isString, isBoolean, isFunction, isObject, isMap,
    isArray, isSet, isDate, isRegExp, isSymbol, isArguments, isError, isJSON,
    isInteger, inRange
} = prelude.type

suite 'getType' !->
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

suite 'isBoolean' !->
    test 'truthy' !->
        strictEqual (isBoolean true), true
        strictEqual (isBoolean false), true

    test 'falsy' !->
        strictEqual (isBoolean 1), false
        strictEqual (isBoolean 0), false
        strictEqual (isBoolean "true"), false

suite 'isFunction' !->
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

suite 'isSet' !->
    test 'truthy' !->
        if Set? and isFunction Set
            strictEqual (isSet new Set!), true

    test 'falsy' !->
        strictEqual (isSet ''), false
        strictEqual (isSet []), false
        strictEqual (isSet null), false
        strictEqual (isSet {}), false
        strictEqual (isSet ->), false


suite 'isObject' !->
    test 'truthy' !->
        strictEqual (isObject {}), true

    test 'falsy' !->
        strictEqual (isObject []), false
        strictEqual (isObject 10), false

# cannot produce a Map for a valid test in node, skip this.
suite 'isMap' !->
    test 'truthy' !->
        if Map? and isFunction Map
            strictEqual (isMap new Map!), true

    test 'falsy' !->
        strictEqual (isMap ''), false
        strictEqual (isMap []), false
        strictEqual (isMap null), false
        strictEqual (isMap {}), false
        strictEqual (isMap ->), false

suite 'isArguments' !->
    test 'truthy' !->
        strictEqual (isArguments &), true

    test 'falsy' !->
        strictEqual (isArguments []), false
        strictEqual (isArguments {}), false
        strictEqual (isArguments new Date), false

suite 'isDate' !->
    test 'truthy' !->
        strictEqual (isDate new Date), true

    test 'falsy' !->
        strictEqual (isDate {}), false
        strictEqual (isDate []), false

suite 'isError' !->
    test 'truthy' !->
        strictEqual (isError new Error 'fail'), true

    test 'falsy' !->
        strictEqual (isError {}), false
        strictEqual (isError {}), false

suite 'isRegExp' !->
    test 'truthy' !->
        strictEqual (isRegExp /foo/), true
        strictEqual (isRegExp new RegExp 'foo'), true

    test 'falsy' !->
        strictEqual (isRegExp ''), false
        strictEqual (isRegExp []), false

# cannot produce a Symbol for a valid test in node, skip this.
suite 'isSymbol' !->
    test 'truthy' !->
        if Symbol? and isFunction Symbol
            strictEqual (isSymbol Symbol!), true
            strictEqual (isSymbol Symbol 'foo'), true

    test 'falsy' !->
        strictEqual (isSymbol ''), false
        strictEqual (isSymbol []), false
        strictEqual (isSymbol null), false
        strictEqual (isSymbol {}), false
        strictEqual (isSymbol ->), false

suite 'isJSON' !->
    test 'truthy' !->
        deepEqual (isJSON '{ "a":1 }'), true
        deepEqual (isJSON '[{ "b":2 }]'), true
        deepEqual (isJSON '[1,2,3]'), true
        deepEqual (isJSON JSON.stringify process.env), true

    test 'falsy' !->
        strictEqual (isJSON null), false
        strictEqual (isJSON 0), false
        strictEqual (isJSON /foo/), false
        strictEqual (isJSON {}), false
        strictEqual (isJSON 'foo'), false
        strictEqual (isJSON '"a":1'), false
        strictEqual (isJSON '{ "a":1, b:2 }'), false

suite 'isInteger' !->
    test 'truthy' !->
        strictEqual (isInteger 1), true
        strictEqual (isInteger 1.0), true
        strictEqual (isInteger 1937892), true

    test 'falsy' !->
        strictEqual (isInteger 1.1), false
        strictEqual (isInteger 99.937892), false

suite 'inRange' !->
    test 'curries' !->
        isFunction (inRange 0, 5)
        strictEqual do
            1 |> inRange 0, 5
            true

    test 'truthy' !->
        strictEqual (inRange 0, 5, 0), true
        strictEqual (inRange 0, 5, 1), true
        strictEqual (inRange 0, 5, 5), true

    test 'falsy' !->
        strictEqual (inRange 0, 5, 6), false
        strictEqual (inRange 0, 5, -1), false
        strictEqual (inRange 0, 5, null), false
