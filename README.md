#Prelude

[![build status](https://img.shields.io/travis/igl/prelude.js.svg?style=flat-square)](https://travis-ci.org/igl/prelude.js)
[![npm version](https://img.shields.io/npm/v/prelude.svg?style=flat-square)](https://www.npmjs.com/package/prelude)
[![npm downloads](https://img.shields.io/npm/dm/prelude.svg?style=flat-square)](https://www.npmjs.com/package/prelude)

Utility set for JS.

- Written in <a href="http://www.livescript.net">LiveScript</a>.
- Inspired by
<a href="http://www.preludels.com/">prelude-ls</a>,
<a href="http://underscorejs.org/">underscore</a> and
<a href="https://github.com/codemix/fast.js">fast.js</a>.
- Every functions can be partially applied and never mutate inputs.
- 300+ Tests

Github pages with more detailed examples are coming soon... (See methods listed blow)

## Example

    var sortPostsByName = prelude.array.sortBy(function (post) { return post.name; });
    var sorted_posts = sortPostsByName posts

### Installation

    npm install prelude

### Methods

All functions with 2 or more arguments can be partially applied and generally return
copies of their inputs, thus treating them as immutable. (With the exception
of `object.assign` where this behavior is desired. Use `.merge` for a immutable version)

Function collection are also exported by their uppercased initial letter.
(prelude.S === prelude.string, prelude.A === prelude.array...)


**Array** `prelude.array.<method>`

- empty
- has
- includes / contains
- clone
- head / first
- tail / rest
- last
- initial
- slice
- splice
- concat
- remove
- removeOne
- flatten
- reverse
- each
- map
- filter / find
- findOne
- shuffle
- every
- some
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
- includes / contains
- keys
- values
- clone
- flatten
- explode
- each
- map
- filter
- every
- some
- partition
- keyOf
- keysOf
- findKey
- findKeys
- fromPairs
- toPairs
- fill
- deepFill
- assign / mixin
- deepAssign / deepMixin
- merge
- deepMerge
- freeze
- deepFreeze
- toJSON
- fromJSON
- fromJSONUnsafe
- definePublic
- definePrivate
- defineStatic
- defineMeta

**String** `prelude.string.<method>`

- empty
- includes / contains
- startsWith
- endsWith
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

**Func** `prelude.func.<method>`

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
- once
- chain

**Type** `prelude.type.<method>`

- getType
- isNumber
- isString
- isBoolean / isBool
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
- isDefined
- isNull
- isUndefined
- isUUID
- isInteger / isInt
- inRange
- isNumberArray
- isStringArray
- isBooleanArray / isBoolArray
- isFunctionArray
- isArrayArray
- isSetArray
- isMapArray
- isArgumentsArray
- isObjectArray
- isDateArray
- isErrorArray
- isRegExpArray
- isSymbolArray
- isNullArray
- isUndefinedArray
- isUUIDArray
- isIntegerArray / isIntArray
- isDefinedArray
- oneOf

# Kudos

Thanks to George Zahariev for LiveScript and prelude-ls which made an
awesome base for this lib.
