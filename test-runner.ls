'use strict'

require! {
    assert : nativeAssert
    './'   : prelude
}

{ mixin } = prelude.objects

function assertType (expected)
    (actual, message) ->
        return if expected is typeof! actual
        throw new assert.AssertionError {
            message: message
            actual: actual
            expected: expected
            operator: 'instanceof'
            stackStartFunction: assertType
        }


global.prelude = prelude

global.expect = require 'expect.js'

global.assert = mixin {}, nativeAssert, {
    'String'   : assertType 'String'
    'Number'   : assertType 'Number'
    'Function' : assertType 'Function'
    'Object'   : assertType 'Object'
    'Array'    : assertType 'Array'
    'RegExp'   : assertType 'RegExp'
    'Error'    : assertType 'Error'
}
