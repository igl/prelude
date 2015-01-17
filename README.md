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

**Array** `prelude.array.<method>`

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

**Object** `prelude.object.<method>`

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
- toJSON
- fromJSON
- definePublic
- definePrivate
- defineStatic
- defineMeta

**String** `prelude.string.<method>`

- empty
- contains
- trim
- trimLeft
- trimRight
- repeat
- reverse
- capitalize
- capitalizeSentence
- decapitalize
- decapitalizeSentence
- camelize
- dasherize

**Number** `prelude.number.<method>`

- even
- odd
- random
- range
- gcd
- lcm

**Fn** `prelude.fn.<method>`

- id
- curry
- compose
- apply
- applyTo
- applyNew
- flip
- delay
- interval
- immediate
- tryCatch

**Type** `prelude.type.<method>`

- getType
- isNumber
- isString
- isBoolean
- isFunction
- isArray
- isSet
- isObject
- isMap
- isArguments
- isDate
- isError
- isRegExp
- isSymbol
- isJSON
- isInteger
- inRange

**ImportAll** `prelude.importAll.<method>`

