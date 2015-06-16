'use strict'

<-! suite 'string'

{
    empty, startsWith, endsWith, contains, trim, trimLeft, trimRight, repeat,
    reverse, capitalize, capitalizeSentence, decapitalize, decapitalizeSentence,
    camelize, dasherize
} = prelude.string

suite 'empty()' !->
    test 'is empty' !->
        ok (empty '')
        ok (not empty 'foo')

suite 'contains()' !->
    test 'contains character' !->
        ok (contains 'o', 'foobar')
        ok (contains 'b', 'foobar')
        ok (not contains 'x', 'foobar')

suite 'startsWith()' !->
    test 'starts with characters' !->
        ok (startsWith 'f', 'foobar')
        ok (startsWith 'foo', 'foobar')
        ok (not startsWith 'x', 'foobar')

suite 'endsWith()' !->
    test 'ends with characters' !->
        ok (endsWith 'r', 'foobar')
        ok (endsWith 'bar', 'foobar')
        ok (not endsWith 'x', 'foobar')

suite 'trim()' !->
    test 'trim left side' !->
        ok (trim '  foo  ', 'foo')
        ok (trim '\t \n foo \n ', 'foo')
        ok (trim '\t \n f o o \n \t\t', 'f o o')

suite 'trimLeft()' !->
    test 'trim left side' !->
        ok (trimLeft '  foo  ', 'foo  ')
        ok (trimLeft ' \t f o o \n\t ', 'f o o \n\t ')

suite 'trimRight()' !->
    test 'trim left side' !->
        ok (trimRight '  foo  ', '  foo')
        ok (trimRight ' \t f o o \n ', ' \t f o o')

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
    test 'camelize a short string' !->
        strictEqual do
            camelize 'hello-World'
            'helloWorld'

    test 'camelize with trailing dashes' !->
        strictEqual do
            camelize 'Hello-World-'
            'HelloWorld'

        strictEqual do
            camelize '-Hello-World'
            'HelloWorld'

suite 'dasherize()' !->
    test 'dasherize a short string' !->
        strictEqual do
            dasherize 'helloWorld'
            'hello-world'

    test 'dasherize a capitalized string' !->
        strictEqual do
            dasherize 'FooBar'
            'foo-bar'

    test 'dasherize a string with a uppercase block' !->
        strictEqual do
            dasherize 'XYZitem'
            'XYZ-item'
