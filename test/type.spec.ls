'use strict'

<-! suite 'type'

{
    getType, isNumber, isString, isBoolean, isFunction, isObject, isMap,
    isArray, isSet, isDate, isRegExp, isSymbol, isArguments, isError,
    isDefined, isNull, isUndefined, isUUID, isInteger, inRange
} = prelude.type

FIXTURE_UUIDS = <[
    720ef950-a4b4-11e4-bf83-ada77868e109
    d9203b21-58c6-40f1-ae18-8a7f67a59f1f
    4fd5d137-9a26-4961-a309-c0a8b08b154f
    b0d85195-fcae-4fa0-bd5b-170e155db2d2
    1fcd79fa-1e62-4de5-8352-e4d0ae6e23b3
    d63bd12b-1b05-4d46-aecd-5c6c99bd777e
    eb878c3b-3d36-480a-bc93-2fe0a964061a
    4f645712-15a9-419e-98be-85341eb33f31
    a3e64ad7-0092-4c54-8c37-9e8bd32cbc56
    1e96ccb8-e677-4443-90d9-ea0ff299ad71
    06dbd5e3-3328-4f90-83e0-f311772e536c
    025179ed-2258-46d6-a433-8bd01584cc6c
]>

suite 'getType()' !->
    test 'get types' !->
        strictEqual (getType 100), 'Number'
        strictEqual (getType ''), 'String'
        strictEqual (getType true), 'Boolean'
        strictEqual (getType false), 'Boolean'
        strictEqual (getType ->), 'Function'
        strictEqual (getType []), 'Array'
        strictEqual (getType {}), 'Object'
        strictEqual (getType &), 'Arguments'
        strictEqual (getType new Date), 'Date'
        strictEqual (getType new Error), 'Error'
        strictEqual (getType /foo/), 'RegExp'
        # es6 only
        if Set? and isFunction Set
            strictEqual (getType new Set), 'Set'

        if Map? and isFunction Map
            strictEqual (getType new Map), 'Map'

        if Symbol? and isFunction Symbol
            strictEqual (getType Symbol!), 'Symbol'


suite 'isNumber()' !->
    test 'truthy' !->
        strictEqual (isNumber 10), true

    test 'falsy' !->
        strictEqual (isNumber ''), false
        strictEqual (isNumber []), false
        strictEqual (isNumber 9e999), false
        strictEqual (isNumber 0 / 0), false

suite 'isString()' !->
    test 'truthy' !->
        strictEqual (isString ''), true

    test 'falsy' !->
        strictEqual (isString []), false
        strictEqual (isString 10), false

suite 'isBoolean()' !->
    test 'truthy' !->
        strictEqual (isBoolean true), true
        strictEqual (isBoolean false), true

    test 'falsy' !->
        strictEqual (isBoolean 1), false
        strictEqual (isBoolean 0), false
        strictEqual (isBoolean "true"), false

suite 'isFunction()' !->
    test 'truthy' !->
        strictEqual (isFunction ->), true

    test 'falsy' !->
        strictEqual (isFunction {}), false
        strictEqual (isFunction /x/), false

suite 'isArray()' !->
    test 'truthy' !->
        strictEqual (isArray []), true

    test 'falsy' !->
        strictEqual (isArray ''), false
        strictEqual (isArray {}), false

suite 'isSet()' !->
    test 'truthy' !->
        strictEqual (isSet new Set), true

    test 'falsy' !->
        strictEqual (isSet ''), false
        strictEqual (isSet []), false
        strictEqual (isSet null), false
        strictEqual (isSet {}), false
        strictEqual (isSet ->), false

suite 'isObject()' !->
    test 'truthy' !->
        strictEqual (isObject {}), true
        strictEqual (isObject []), true

    test 'falsy' !->
        strictEqual (isObject 10), false
        strictEqual (isObject null), false

suite 'isMap()' !->
    test 'truthy' !->
        strictEqual (isMap new Map), true

    test 'falsy' !->
        strictEqual (isMap ''), false
        strictEqual (isMap []), false
        strictEqual (isMap null), false
        strictEqual (isMap {}), false
        strictEqual (isMap ->), false

suite 'isArguments()' !->
    test 'truthy' !->
        strictEqual (isArguments &), true

    test 'falsy' !->
        strictEqual (isArguments []), false
        strictEqual (isArguments {}), false
        strictEqual (isArguments new Date), false

suite 'isDate()' !->
    test 'truthy' !->
        strictEqual (isDate new Date), true

    test 'falsy' !->
        strictEqual (isDate {}), false
        strictEqual (isDate []), false

suite 'isError()' !->
    test 'truthy' !->
        strictEqual (isError new Error 'fail'), true

    test 'falsy' !->
        strictEqual (isError {}), false
        strictEqual (isError {}), false

suite 'isRegExp()' !->
    test 'truthy' !->
        strictEqual (isRegExp /foo/), true
        strictEqual (isRegExp new RegExp 'foo'), true

    test 'falsy' !->
        strictEqual (isRegExp ''), false
        strictEqual (isRegExp []), false

suite 'isSymbol()' !->
    test 'truthy' !->
        strictEqual (isSymbol Symbol!), true
        strictEqual (isSymbol Symbol 'foo'), true

    test 'falsy' !->
        strictEqual (isSymbol ''), false
        strictEqual (isSymbol []), false
        strictEqual (isSymbol null), false
        strictEqual (isSymbol {}), false

suite 'isDefined()' !->
    test 'truthy' !->
        strictEqual (isDefined 0), true
        strictEqual (isDefined ''), true
        strictEqual (isDefined []), true
        strictEqual (isDefined {}), true
        strictEqual (isDefined ->), true

    test 'falsy' !->
        strictEqual (isDefined null), false
        strictEqual (isDefined undefined), false

suite 'isNull()' !->
    test 'truthy' !->
        strictEqual (isNull null), true

    test 'falsy' !->
        strictEqual (isNull undefined), false
        strictEqual (isNull ''), false
        strictEqual (isNull []), false
        strictEqual (isNull {}), false
        strictEqual (isNull ->), false

suite 'isUndefined()' !->
    test 'truthy' !->
        strictEqual (isUndefined undefined), true

    test 'falsy' !->
        strictEqual (isUndefined null), false
        strictEqual (isUndefined ''), false
        strictEqual (isUndefined []), false
        strictEqual (isUndefined {}), false
        strictEqual (isUndefined ->), false

suite 'isUUID()' !->
    test 'validate all uuids from fixtures' !->
        for uuid in FIXTURE_UUIDS
            strictEqual (isUUID uuid), true

    test 'fail on invalid input' !->
        strictEqual (isUUID 36), false
        strictEqual (isUUID {}), false
        strictEqual (isUUID 'foo'), false
        strictEqual (isUUID 'foobarfoobarfoobarfoobarfoobarfoobar'), false
        strictEqual (isUUID '06dbd5e3-3328-4f90-83e0-f311772e536'), false
        strictEqual (isUUID '06dbd5e3-3328-4f90-83e0-f311772e536cg'), false
        strictEqual (isUUID '06dbd5e3-3328-4z90-83e0-f311772e536c'), false

suite 'isInteger()' !->
    test 'truthy' !->
        strictEqual (isInteger 1), true
        strictEqual (isInteger 1.0), true
        strictEqual (isInteger 1937892), true

    test 'falsy' !->
        strictEqual (isInteger 1.1), false
        strictEqual (isInteger 99.937892), false

suite 'inRange()' !->
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
