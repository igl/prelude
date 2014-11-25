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

**Arrays** `prelude.arrays.<method>`

- empty
- has
- contains
- clone
- head
- first
- tail
- last
- initial
- slice
- concat
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
- has
- contains
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

- empty
- contains
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
- compose
- apply
- applyTo
- applyNew
- flip
- chain
- concurrent
- delay
- interval
- immediate
- tryCatch
- Class

**Types** `prelude.types.<method>`

- getType
- isNumber
- isString
- isBoolean
- isFunction
- isArray
- isObject
- isArguments
- isDate
- isError
- isRegExp
- isJSON
