'use strict'

require('core-js')

require! {
    assert
    './'   : prelude
}

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

# Mock the Promise functions in old node versions
# (required for test of isPromise())
unless global.Promise
    global.Promise = function Promise =>

# set global assert funcs
Object.assign global, {
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
