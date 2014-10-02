'use strict'

export strings = require './strings'
export numbers = require './numbers'
export arrays  = require './arrays'
export objects = require './objects'
export funcs   = require './funcs'
export types   = require './types'


# generate readme index
# for k of exports
#     console.log "\n**#{ strings.capitalize k }** `prelude.#k.<method>`\n"
#     for m of exports[k]
#         console.log "- #m"
