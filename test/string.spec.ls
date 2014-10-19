'use strict'

<-! suite 'prelude.strings'

suite 'repeat()' !->
    { repeat } = prelude.strings

    test 'repeat string x times' !->
        strictEqual do
            repeat 3, 'x'
            'xxx'

suite 'reverse()' !->
    { reverse } = prelude.strings

    test 'reverse a string' !->
        strictEqual do
            reverse 'abc'
            'cba'

suite 'capitalize()' !->
    { capitalize } = prelude.strings

    test 'capitalize a string' !->
        strictEqual do
            capitalize 'hello world'
            'Hello world'

suite 'capitalizeSentence()' !->
    { capitalizeSentence } = prelude.strings

    test 'capitalize a sentence' !->
        strictEqual do
            capitalizeSentence 'hello world'
            'Hello World'


suite 'decapitalize()' !->
    { decapitalize } = prelude.strings

    test 'decapitalize a string' !->
        strictEqual do
            decapitalize 'Hello world'
            'hello world'

suite 'decapitalizeSentence()' !->
    { decapitalizeSentence } = prelude.strings

    test 'decapitalizeSentence a string' !->
        strictEqual do
            decapitalizeSentence 'Hello World'
            'hello world'


suite 'camelize()' !->
    { camelize } = prelude.strings

    test 'camelize a string' !->
        strictEqual do
            camelize 'hello-World'
            'helloWorld'

suite 'dasherize()' !->
    { dasherize } = prelude.strings

    test 'dasherize a string' !->
        strictEqual do
            dasherize 'helloWorld'
            'hello-world'
