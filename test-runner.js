'use strict'

var assert = require('assert');

global.expect      = require('expect.js');

global.ok          = assert.ok;
global.strictEqual = assert.strictEqual;
global.deepEqual   = assert.deepEqual;
global.typeEqual   = function (expected, actual) {
    var result = Object.prototype.toString.call(actual).slice(8, -1);
    if (expected !== result) {
        throw new assert.AssertionError({
            message: ('Expected ' + result + ' to be a ' + expected),
            actual: actual,
            expected: expected,
            operator: 'instanceof',
            stackStartFunction: typeEqual
        });
    }
};

