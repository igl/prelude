#Prelude [![Build Status](https://travis-ci.org/igl/prelude.js.png?branch=master)](https://travis-ci.org/igl/prelude.js)

Utility set for JS.

- Written in <a href="http://www.livescript.net">LiveScript</a>.
- Inspired by
<a href="http://www.preludels.com/">prelude-ls</a>,
<a href="http://underscorejs.org/">underscore</a> and
<a href="https://github.com/codemix/fast.js">fast.js</a>.
- See method index below
- Github pages with more detailed examples are coming soon...

## Example

    var sortPostsByName = prelude.array.sortBy(function (post) { return post.name; });
    var sorted_posts = sortPostsByName posts

### Installation

    npm install prelude

### Methods

All functions with 2 or more arguments are curried and generally return
copies of their inputs, thus treating them as immutable (with the exception
of `object.assign` and `.deepAssign` where this behavior is not always wanted).

Function collection are also exported by their uppercased initial letter.
(prelude.S === prelude.string, prelude.A === prelude.array...)


**Array** `prelude.array.<method>`

- empty
- has
- includes
- clone
- head
- first
- tail
- last
- initial
- slice
- concat
- flatten
- reverse
- each
- map
- filter
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
- includes
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
- assign
- deepAssign
- merge
- deepMerge
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
- includes
- contains
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
- chain

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
- isDefined
- isNull
- isUndefined
- isUUID
- isInteger
- inRange
- isNumberArray
- isStringArray
- isBooleanArray
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
- isIntegerArray
- isDefinedArray

# Kudos

Thanks to George Zahariev for LiveScript and `prelude-ls` which made an
awesome base for this lib.

