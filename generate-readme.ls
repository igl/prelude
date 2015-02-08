
# generate index for README

prelude = require './'

HEAD = '''
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
    of `object.mixin` where this behavior is not always wanted).

    '''

console.log HEAD

for key of prelude
    console.log "\n**#{ prelude.string.capitalize key }** `prelude.#key.<method>`\n"
    for fn of prelude[key]
        console.log "- #fn"
