'use strict'

<-! suite 'type'

{
    isNumberArray, isStringArray, isBooleanArray, isFunctionArray,
    isObjectArray, isMapArray, isArrayArray, isSetArray, isDateArray,
    isRegExpArray, isSymbolArray, isArgumentsArray, isErrorArray,
    isNullArray, isUndefinedArray, isDefinedArray,
    isUUIDArray, isIntegerArray
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

suite 'isNumberArray()' !->
    test 'truthy' !->
        strictEqual (isNumberArray [1]), true
        strictEqual (isNumberArray [1.0, 2, 3.3333]), true
        strictEqual (isNumberArray [1 2 3 4]), true

    test 'falsy' !->
        strictEqual (isNumberArray 1), false
        strictEqual (isNumberArray []), false
        strictEqual (isNumberArray ['foo']), false
        strictEqual (isNumberArray [1 '2']), false
        strictEqual (isNumberArray [/foo/]), false
        strictEqual (isNumberArray [{}]), false
        strictEqual (isNumberArray 9e999), false
        strictEqual (isNumberArray 0 / 0), false
        strictEqual (isNumberArray [0 / 0]), false

suite 'isStringArray()' !->
    test 'truthy' !->
        strictEqual (isStringArray ['']), true
        strictEqual (isStringArray ['foo']), true
        strictEqual (isStringArray ['foo' 'bar']), true

    test 'falsy' !->
        strictEqual (isStringArray 'foo'), false
        strictEqual (isStringArray []), false
        strictEqual (isStringArray [1]), false
        strictEqual (isStringArray ['1' 2]), false
        strictEqual (isStringArray [1 '2']), false
        strictEqual (isStringArray 10), false

suite 'isBooleanArray()' !->
    test 'truthy' !->
        strictEqual (isBooleanArray [true]), true
        strictEqual (isBooleanArray [false]), true
        strictEqual (isBooleanArray [true false]), true

    test 'falsy' !->
        strictEqual (isBooleanArray true), false
        strictEqual (isBooleanArray []), false
        strictEqual (isBooleanArray [1]), false
        strictEqual (isBooleanArray [0]), false
        strictEqual (isBooleanArray [true "false"]), false
        strictEqual (isBooleanArray ["true"]), false

suite 'isFunctionArray()' !->
    test 'truthy' !->
        strictEqual (isFunctionArray [->]), true
        strictEqual (isFunctionArray [(->),(->),(->)]), true

    test 'falsy' !->
        strictEqual (isFunctionArray ->), false
        strictEqual (isFunctionArray []), false
        strictEqual (isFunctionArray [{}]), false
        strictEqual (isFunctionArray [/x/]), false
        strictEqual (isFunctionArray [(->), 'foo']), false

suite 'isArrayArray()' !->
    test 'truthy' !->
        strictEqual (isArrayArray [[]]), true
        strictEqual (isArrayArray [[1],[2],[3]]), true

    test 'falsy' !->
        strictEqual (isArrayArray []), false
        strictEqual (isArrayArray ['foo']), false
        strictEqual (isArrayArray [{}]), false
        strictEqual (isArrayArray [[], 'foo']), false

suite 'isSetArray()' !->
    test 'truthy' !->
        strictEqual (isSetArray [new Set]), true
        strictEqual (isSetArray [(new Set),(new Set),(new Set)]), true

    test 'falsy' !->
        strictEqual (isSetArray new Set), false
        strictEqual (isSetArray []), false
        strictEqual (isSetArray ['']), false
        strictEqual (isSetArray [[]]), false
        strictEqual (isSetArray [null]), false
        strictEqual (isSetArray [{}]), false
        strictEqual (isSetArray [->]), false
        strictEqual (isSetArray [(new Set), 'foo']), false

suite 'isObjectArray()' !->
    test 'truthy' !->
        strictEqual (isObjectArray [{}]), true
        strictEqual (isObjectArray [{},{},{}]), true

    test 'falsy' !->
        strictEqual (isObjectArray {}), false
        strictEqual (isObjectArray []), false
        strictEqual (isObjectArray [new Map]), false
        strictEqual (isObjectArray [/x/]), false
        strictEqual (isObjectArray [[]]), false
        strictEqual (isObjectArray [10]), false
        strictEqual (isObjectArray [null]), false
        strictEqual (isObjectArray [(new Map), 'foo']), false

suite 'isMapArray()' !->
    test 'truthy' !->
        strictEqual (isMapArray [new Map]), true
        strictEqual (isMapArray [(new Map),(new Map),(new Map)]), true

    test 'falsy' !->
        strictEqual (isMapArray new Map), false
        strictEqual (isMapArray ['']), false
        strictEqual (isMapArray [[]]), false
        strictEqual (isMapArray [null]), false
        strictEqual (isMapArray [{}]), false
        strictEqual (isMapArray [->]), false
        strictEqual (isMapArray [(new Map), 'foo']), false

suite 'isArgumentsArray()' !->
    test 'truthy' !->
        strictEqual (isArgumentsArray [&]), true
        strictEqual (isArgumentsArray [&, &, &]), true

    test 'falsy' !->
        strictEqual (isArgumentsArray &), false
        strictEqual (isArgumentsArray []), false
        strictEqual (isArgumentsArray [[]]), false
        strictEqual (isArgumentsArray [{}]), false
        strictEqual (isArgumentsArray [new Date]), false

suite 'isDateArray()' !->
    test 'truthy' !->
        strictEqual (isDateArray [new Date]), true
        strictEqual (isDateArray [(new Date),(new Date),(new Date)]), true

    test 'falsy' !->
        strictEqual (isDateArray new Date), false
        strictEqual (isDateArray [(new Date), 1]), false
        strictEqual (isDateArray [{}]), false
        strictEqual (isDateArray [[]]), false
        strictEqual (isDateArray [873249837]), false
        strictEqual (isDateArray ['Sun Aug 16 2015 17:31:52 GMT+0200 (CEST)']), false

suite 'isErrorArray()' !->
    test 'truthy' !->
        strictEqual (isErrorArray [new Error 'fail']), true
        strictEqual (isErrorArray [(new Error),(new Error),(new Error)]), true

    test 'falsy' !->
        strictEqual (isErrorArray new Error 'fail'), false
        strictEqual (isErrorArray [(new Error 'fail'), 1]), false
        strictEqual (isErrorArray [{}]), false
        strictEqual (isErrorArray [{}]), false
        strictEqual (isErrorArray ['Error']), false

suite 'isRegExpArray()' !->
    test 'truthy' !->
        strictEqual (isRegExpArray [/foo/]), true
        strictEqual (isRegExpArray [/foo/,/foo/,/foo/]), true

    test 'falsy' !->
        strictEqual (isRegExpArray /foo/), false
        strictEqual (isRegExpArray [/foo/, 1]), false
        strictEqual (isRegExpArray [[]]), false
        strictEqual (isRegExpArray [{}]), false
        strictEqual (isRegExpArray [1]), false

suite 'isSymbolArray()' !->
    test 'truthy' !->
        strictEqual (isSymbolArray [Symbol!]), true
        strictEqual (isSymbolArray [Symbol!,Symbol!,Symbol!]), true

    test 'falsy' !->
        strictEqual (isSymbolArray Symbol!), false
        strictEqual (isSymbolArray [Symbol!, 1]), false
        strictEqual (isSymbolArray [[]]), false
        strictEqual (isSymbolArray [{}]), false

suite 'isDefinedArray()' !->
    test 'truthy' !->
        strictEqual (isDefinedArray [0]), true
        strictEqual (isDefinedArray ['']), true
        strictEqual (isDefinedArray [[]]), true
        strictEqual (isDefinedArray [{}]), true
        strictEqual (isDefinedArray [->]), true
        strictEqual (isDefinedArray [1, 'foo', {}]), true

    test 'falsy' !->
        strictEqual (isDefinedArray [null]), false
        strictEqual (isDefinedArray [undefined]), false
        strictEqual (isDefinedArray [1, 'foo', undefined]), false
        strictEqual (isDefinedArray [0, 'foo', null]), false

suite 'isNullArray()' !->
    test 'truthy' !->
        strictEqual (isNullArray [null]), true
        strictEqual (isNullArray [null, null, null]), true

    test 'falsy' !->
        strictEqual (isNullArray [undefined]), false
        strictEqual (isNullArray [null, undefined]), false
        strictEqual (isNullArray ['']), false
        strictEqual (isNullArray [[]]), false
        strictEqual (isNullArray [{}]), false
        strictEqual (isNullArray [->]), false

suite 'isUndefinedArray()' !->
    test 'truthy' !->
        strictEqual (isUndefinedArray [void]), true
        strictEqual (isUndefinedArray [undefined, undefined, undefined]), true

    test 'falsy' !->
        strictEqual (isUndefinedArray [null]), false
        strictEqual (isUndefinedArray [undefined, null]), false
        strictEqual (isUndefinedArray [undefined, 0]), false
        strictEqual (isUndefinedArray ['']), false
        strictEqual (isUndefinedArray [[]]), false
        strictEqual (isUndefinedArray [{}]), false
        strictEqual (isUndefinedArray [->]), false

suite 'isUUIDArray()' !->
    uuid1 = FIXTURE_UUIDS[0]
    uuid2 = FIXTURE_UUIDS[1]
    uuid3 = FIXTURE_UUIDS[2]

    test 'validate all UUIDs from fixtures' !->
        for uuid in FIXTURE_UUIDS
            strictEqual (isUUIDArray [uuid]), true

    test 'truthy' !->
        strictEqual (isUUIDArray [uuid1]), true
        strictEqual (isUUIDArray [uuid1, uuid2, uuid3]), true

    test 'falsy' !->
        strictEqual (isUUIDArray [36]), false
        strictEqual (isUUIDArray [{}]), false
        strictEqual (isUUIDArray ['foo']), false
        strictEqual (isUUIDArray [uuid1, uuid2, 'foobarfoobarfoobarfoobarfoobarfoobar']), false
        strictEqual (isUUIDArray ['foobarfoobarfoobarfoobarfoobarfoobar']), false
        strictEqual (isUUIDArray ['06dbd5e3-3328-4f90-83e0-f311772e536']), false
        strictEqual (isUUIDArray ['06dbd5e3-3328-4f90-83e0-f311772e536cg']), false
        strictEqual (isUUIDArray ['06dbd5e3-3328-4z90-83e0-f311772e536c']), false

suite 'isIntegerArray()' !->
    test 'truthy' !->
        strictEqual (isIntegerArray [1]), true
        strictEqual (isIntegerArray [1.0]), true
        strictEqual (isIntegerArray [1937892]), true

    test 'falsy' !->
        strictEqual (isIntegerArray [1.1]), false
        strictEqual (isIntegerArray [99.937892]), false
