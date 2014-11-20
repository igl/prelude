'use strict'

<-! suite 'prelude.string'

{
    empty, contains, repeat, reverse, capitalize, capitalizeSentence,
    decapitalize, decapitalizeSentence, camelize, dasherize
} = prelude.strings

suite 'empty()' !->
    test 'is empty' !->
        ok (empty '')
        ok (not empty 'foo')

suite 'contains()' !->
    test 'contains character' !->
        ok (contains 'b', 'foobar')
        ok (not contains 'x', 'foobar')

suite 'repeat()' !->
    test 'repeat string x times' !->
        strictEqual do
            repeat 3, 'x'
            'xxx'

suite 'reverse()' !->
    test 'reverse a string' !->
        strictEqual do
            reverse 'abc'
            'cba'

suite 'capitalize()' !->
    test 'capitalize a string' !->
        strictEqual do
            capitalize 'hello world'
            'Hello world'

suite 'capitalizeSentence()' !->
    test 'capitalize a sentence' !->
        strictEqual do
            capitalizeSentence 'hello world'
            'Hello World'


suite 'decapitalize()' !->
    test 'decapitalize a string' !->
        strictEqual do
            decapitalize 'Hello world'
            'hello world'

suite 'decapitalizeSentence()' !->
    test 'decapitalizeSentence a string' !->
        strictEqual do
            decapitalizeSentence 'Hello World'
            'hello world'


suite 'camelize()' !->
    test 'camelize a string' !->
        strictEqual do
            camelize 'hello-World'
            'helloWorld'

suite 'dasherize()' !->
    test 'dasherize a string' !->
        strictEqual do
            dasherize 'helloWorld'
            'hello-world'
