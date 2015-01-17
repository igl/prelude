
# generate index for README

prelude = require './'

HEAD = '''
    #Prelude

    Utility set for ECMAScript.
    Includes a lot of common helpers for primitive transformation, control flow and inheritance.
    All functions with 2 or more arguments are curried.

    - Written in <a href="http://www.livescript.net">LiveScript</a>, because Javascript.
    - Inspired by
    <a href="http://www.preludels.com/">prelude-ls</a>,
    <a href="http://underscorejs.org/">underscore</a> and
    <a href="https://github.com/codemix/fast.js">fast.js</a>.

    ### Install:

        npm install prelude

    ### Method Index:
    '''

console.log HEAD

for key of prelude
    console.log "\n**#{ prelude.string.capitalize key }** `prelude.#key.<method>`\n"
    for fn of prelude[key]
        console.log "- #fn"
