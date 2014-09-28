'use strict'

# repeat :: string -> string
export repeat = (n, str) -->
    result = ''
    for til n
        result += str
    result

# reverse :: string -> string
export reverse = (str) ->
    str.split '' .reverse!.join ''

# capitalize :: string -> string
export capitalize = (str) ->
  (str.char-at 0).to-upper-case! + str.slice 1

# capitalizeSentence :: string -> string
export capitalizeSentence = (str) ->
    str.replace /(^.|\s.)/g, (, c) -> (c ? '').to-upper-case!

# camelize :: string -> string
export camelize = (str) ->
    str.replace /[-_]+(.)?/g, (, c) -> (c ? '').to-upper-case!

# dasherize :: string -> string
export dasherize = (str) ->
    str
        .replace /([^-A-Z])([A-Z]+)/g, (, lower, upper) ->
            upper = if upper.length > 1 then upper else upper.to-lower-case!
            lower + '-' + upper
        .replace /^([A-Z]+)/, (, upper) ->
            if upper.length > 1 then "#upper-" else upper.to-lower-case!
