# generate function index for README

prelude = require './'

{ S } = prelude

console.log '''
    #Prelude [![Build Status](https://travis-ci.org/igl/prelude.js.png?branch=master)](https://travis-ci.org/igl/prelude.js)

    Utility set for JS.

    - Written in <a href="http://www.livescript.net">LiveScript</a>.
    - Inspired by
    <a href="http://www.preludels.com/">prelude-ls</a>,
    <a href="http://underscorejs.org/">underscore</a> and
    <a href="https://github.com/codemix/fast.js">fast.js</a>.
    - See method index below
    - Github pages with more detailed examples are coming soon...

    ## Example

        var sortPostsByName = prelude.array.sortBy(function (post) { return post.name; });
        var sorted_posts = sortPostsByName posts

    ### Installation

        npm install prelude

    ### Methods

    All functions with 2 or more arguments are curried and generally return
    copies of their inputs, thus treating them as immutable (with the exception
    of `object.assign` and `.deepAssign` where this behavior is not always wanted).

    Function collection are also exported by their uppercased initial letter.
    (prelude.S === prelude.string, prelude.A === prelude.array...)

    '''

for key of prelude when key.length > 1
    console.log "\n**#{ S.capitalize key }** `prelude.#key.<method>`\n"
    for fn of prelude[key]
        console.log "- #fn"

console.log '''

    # Kudos

    Thanks to George Zahariev for LiveScript and `prelude-ls` which made an
    awesome base for this lib.

    '''
