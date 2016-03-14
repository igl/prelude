# Prelude

[![build status](https://img.shields.io/travis/igl/prelude.js.svg?style=flat-square)](https://travis-ci.org/igl/prelude.js)
[![npm version](https://img.shields.io/npm/v/prelude.svg?style=flat-square)](https://www.npmjs.com/package/prelude)
[![npm downloads](https://img.shields.io/npm/dm/prelude.svg?style=flat-square)](https://www.npmjs.com/package/prelude)

Utility set for JS.
All functions with 2 or more arguments can be partially applied and generally return
copies of their inputs, thus treating them as immutable.

Github pages with more detailed examples are coming soon... (All methods are listed below)

- Written in <a href="http://www.livescript.net">LiveScript</a>.
- Inspired by
<a href="http://www.preludels.com/">prelude-ls</a>,
<a href="http://underscorejs.org/">underscore</a> and
<a href="https://github.com/codemix/fast.js">fast.js</a>.
- Every function can be partially applied and ***never*** mutates input.
- 300+ Tests


## Examples

Function collection are also exported by their uppercased initial letter.
(prelude.S === prelude.string, prelude.A === prelude.array...)

Get Functions:

    import { array, O } from 'prelude'
    import { isArray } from 'prelude/lib/type'

Use Functions:

    if (isArray(xs)) {
        array.map(o => O.merge(o, { visited: true }))(xs)(xs)
    }

Create helper using partial application:

    const sortPostsByName = prelude.array.sortBy(post => post.name)
    const sorted_posts = sortPostsByName(posts)

Handy for Promises (TODO: use rx):

    getPosts('*')
        .then(sortPostsByName)
        .then(sorted_posts => joyful(true))


### Installation

    npm install --save prelude


### Methods

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
- getExtendedType
- isNumber
- isString
- isBoolean / isBool
- isFunction
- isPromise
- isArray
- isSet
- isObject
- isMap
- isArguments
- isDate
- isError
- isRegExp
- isSymbol
- isNull
- isUndefined
- isPlainObject
- isDefined
- isUUID
- isInteger / isInt
- inRange
- isNumberArray
- isStringArray
- isBooleanArray / isBoolArray
- isFunctionArray
- isPromiseArray
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
- isPlainObjectArray
- isUUIDArray
- isIntegerArray / isIntArray
- isDefinedArray
- oneOf

# Kudos

Thanks to George Zahariev for LiveScript and prelude-ls which made an
awesome base for this lib.
