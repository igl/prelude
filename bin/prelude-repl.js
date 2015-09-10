#!/usr/bin/env node

var fs   = require('fs'),
    path = require('path'),
    repl = require('repl'),
    prelude = require(path.join(path.dirname(fs.realpathSync(__filename)), '../lib/prelude'));

global.array  = global.A = prelude.A;
global.object = global.O = prelude.O;
global.string = global.S = prelude.S;
global.number = global.N = prelude.N;
global.func   = global.F = prelude.F;
global.type   = global.T = prelude.T;


repl.start({ prompt: 'λ '});
