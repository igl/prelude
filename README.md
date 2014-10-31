#Prelude

Utility set for ECMAScript.
Includes a lot of common helpers for primitive transformations, control flow and inheritance.
All functions with 2 or more arguments are curried for a smooth integration with your API.

- Written in <a href="http://www.livescript.net">LiveScript</a>, because Javascript.
- Inspired by
<a href="http://www.preludels.com/">prelude-ls</a>,
<a href="http://underscorejs.org/">underscore</a> and
<a href="https://github.com/codemix/fast.js">fast.js</a>.

### Install:

    npm install prelude

### Method Index:

**Arrays** `prelude.arrays.<method>`

- empty
- clone
- head
- first
- tail
- last
- initial
- slice
- flatten
- each
- map
- filter
- shuffle
- reverse
- zip
- zipWith
- partition
- unique
- uniqueBy
- difference
- intersection
- union
- sortBy
- countBy
- groupBy
- splitAt
- index
- indices
- findIndex
- findIndices

**Objects** `prelude.objects.<method>`

- empty
- keys
- values
- clone
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
- fill
- deepFill
- mixin
- deepMixin
- freeze
- deepFreeze
- toString
- fromString
- definePublic
- definePrivate
- defineStatic
- defineMeta

**Strings** `prelude.strings.<method>`

- repeat
- reverse
- capitalize
- capitalizeSentence
- decapitalize
- decapitalizeSentence
- camelize
- dasherize

**Numbers** `prelude.numbers.<method>`

- even
- odd
- random
- range
- gcd
- lcm

**Funcs** `prelude.funcs.<method>`

- noop
- curry
- apply
- applyTo
- applyNew
- flip
- chain
- concurrent
- tryCatch
- Class

**Types** `prelude.types.<method>`

- getType
- isType
- isFunction
- isObject
- isArray
- isString
- isNumber
- isDate
- isRegExp
- isArguments
- isError
