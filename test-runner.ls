'use strict'

require! {
    assert
    './'   : prelude
}

{ mixin } = prelude.object

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

# set global assert funcs
mixin global, {
    prelude     : prelude
    ok          : assert.ok
    throws      : assert.throws
    deepEqual   : assert.deepEqual
    strictEqual : assert.strictEqual
    isString    : assertType 'String'
    isNumber    : assertType 'Number'
    isFunction  : assertType 'Function'
    isObject    : assertType 'Object'
    isArray     : assertType 'Array'
    isRegExp    : assertType 'RegExp'
    isDate      : assertType 'Date'
    isError     : assertType 'Error'
    isArguments : assertType 'Arguments'
}
