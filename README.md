#Prelude

Utility set for <strike>Java</strike>ECMAScript.
Includes a lot of common helpers for primitive transformations and control flow. Most functions are curried for a smooth integration with your API.

- Written in <a href="http://www.livescript.net">LiveScript</a>, because Javascript.
- Inspired by
<a href="http://www.preludels.com">prelude-ls</a>,
<a href="http://underscorejs.org/">underscore</a> and
<a href="https://github.com/codemix/fast.js">fast.fs</a>.
- JS-orientated (does NOT includes abstractions for trivial things like head, tail, chars, now)

### Install:

    npm install prelude

### Method Index:

**Strings** `prelude.strings.<method>`

- repeat
- reverse
- capitalize
- capitalizeSentence
- camelize
- dasherize

**Numbers** `prelude.numbers.<method>`

- even
- odd
- random
- range
- gcd
- lcm

**Arrays** `prelude.arrays.<method>`

- empty
- clone
- each
- map
- filter
- flatten
- shuffle
- reverse
- partition
- unique
- uniqueBy
- difference
- intersection
- union
- countBy
- groupBy
- sortBy
- splitAt
- indexOf
- IndicesOf
- findIndex
- findIndices

**Objects** `prelude.objects.<method>`

- empty
- clone
- keys
- values
- each
- map
- filter
- partition
- keyOf
- keysOf
- findKey
- findKeys
- fromPairs
- toPairs
- hasOwnProperty
- mixin
- deepMixin
- fill
- deepFill
- freeze
- deepFreeze
- toString
- parseString
- fromString

**Funcs** `prelude.funcs.<method>`

- curry
- apply
- chain
- tryCatch
- flip

**Types** `prelude.types.<method>`

- getType
- isType
