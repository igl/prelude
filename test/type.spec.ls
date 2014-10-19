'use strict'

<-! suite 'prelude.type'

{
    getType, isType, isFunction, isObject, isArray, isString,
    isNumber, isDate, isRegExp, isArguments, isError
} = prelude.types

suite 'getType()' !->

    test 'get types' !->
        strictEqual (getType ->        ), 'Function'
        strictEqual (getType {}        ), 'Object'
        strictEqual (getType []        ), 'Array'
        strictEqual (getType ''        ), 'String'
        strictEqual (getType 10        ), 'Number'
        strictEqual (getType new Date  ), 'Date'
        strictEqual (getType /foo/     ), 'RegExp'
        strictEqual (getType &         ), 'Arguments'
        strictEqual (getType new Error ), 'Error'


suite 'Function' !->
    test 'isType()' !->
        strictEqual (isType 'Function' ->), true
        strictEqual ((->) |> isType 'Function'), true

    test 'isFunction()' !->
        strictEqual (isFunction ->), true
        strictEqual (isFunction {}), false
        strictEqual (isFunction /x/), false

suite 'Object' !->
    test 'isType()' !->
        strictEqual (isType 'Object' {}), true
        strictEqual ({} |> isType 'Object'), true

    test 'isObject()' !->
        strictEqual (isObject {}), true
        strictEqual (isObject []), false
        strictEqual (isObject 10), false

suite 'Array' !->
    test 'isType()' !->
        strictEqual (isType 'Array' []), true
        strictEqual ([] |> isType 'Array'), true

    test 'isArray()' !->
        strictEqual (isArray []), true
        strictEqual (isArray ''), false
        strictEqual (isArray {}), false


suite 'String' !->
    test 'isType()' !->
        strictEqual (isType 'String' ''), true
        strictEqual ('' |> isType 'String'), true

    test 'isString()' !->
        strictEqual (isString ''), true
        strictEqual (isString []), false
        strictEqual (isString 10), false

suite 'Number' !->
    test 'isType()' !->
        strictEqual (isType 'Number' 20), true
        strictEqual (30 |> isType 'Number'), true

    test 'isNumber()' !->
        strictEqual (isNumber 10), true
        strictEqual (isNumber ''), false
        strictEqual (isNumber []), false


suite 'Date' !->
    test 'isType()' !->
        strictEqual (isType 'Date' new Date), true
        strictEqual (new Date |> isType 'Date'), true

    test 'isDate()' !->
        strictEqual (isDate new Date), true
        strictEqual (isDate {}), false
        strictEqual (isDate []), false

suite 'RegExp' !->
    test 'isType()' !->
        strictEqual (isType 'RegExp' new RegExp), true
        strictEqual (new RegExp |> isType 'RegExp'), true

    test 'isRegExp()' !->
        strictEqual (isRegExp /foo/), true
        strictEqual (isRegExp new RegExp 'foo'), true
        strictEqual (isRegExp ''), false
        strictEqual (isRegExp []), false

suite 'Arguments' !->
    test 'isType' !->
        strictEqual (isType 'Arguments' &), true
        strictEqual (& |> isType 'Arguments'), true

    test 'isArguments()' !->
        strictEqual (isArguments &), true
        strictEqual (isArguments []), false

suite 'Error' !->
    test 'isType' !->
        strictEqual (isType 'Error' new Error), true
        strictEqual (new Error |> isType 'Error'), true

    test 'isError()' !->
        strictEqual (isError new Error), true
        strictEqual (isError {}), false
