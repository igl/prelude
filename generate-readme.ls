# generate function index for README

util    = require('util')
prelude = require './'

{ A, S } = prelude

print = -> process.stdout.write (util.format ...&)

print '''
    #Prelude

    [![build status](https://img.shields.io/travis/igl/prelude.js.svg?style=flat-square)](https://travis-ci.org/igl/prelude.js)
    [![npm version](https://img.shields.io/npm/v/prelude.svg?style=flat-square)](https://www.npmjs.com/package/prelude)
    [![npm downloads](https://img.shields.io/npm/dm/prelude.svg?style=flat-square)](https://www.npmjs.com/package/prelude)

    Utility set for JS.

    - Written in <a href="http://www.livescript.net">LiveScript</a>.
    - Inspired by
    <a href="http://www.preludels.com/">prelude-ls</a>,
    <a href="http://underscorejs.org/">underscore</a> and
    <a href="https://github.com/codemix/fast.js">fast.js</a>.
    - Every functions can be partially applied and never mutate inputs.
    - 300+ Tests

    Github pages with more detailed examples are coming soon... (See methods listed blow)

    ## Example

        var sortPostsByName = prelude.array.sortBy(function (post) { return post.name; });
        var sorted_posts = sortPostsByName posts

    ### Installation

        npm install prelude

    ### Methods

    All functions with 2 or more arguments can be partially applied and generally return
    copies of their inputs, thus treating them as immutable. (With the exception
    of `object.assign` where this behavior is desired. Use `.merge` for a immutable version)

    Function collection are also exported by their uppercased initial letter.
    (prelude.S === prelude.string, prelude.A === prelude.array...)


    '''

consumed = []
for key of prelude when key.length > 1
    print "\n**#{ S.capitalize key }** `prelude.#key.<method>`\n\n"

    consumed = []
    for fn1, v1 of prelude[key] when not A.includes fn1, consumed
        print "- #fn1"
        consumed.push fn1
        for fn2, v2 of prelude[key] when v1 is v2 and fn1 isnt fn2
            consumed.push fn2
            print " / #fn2"
        print "\n"

print '''

    # Kudos

    Thanks to George Zahariev for LiveScript and prelude-ls which made an
    awesome base for this lib.

    '''
