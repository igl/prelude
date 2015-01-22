'use strict'

<-! suite 'number'

{ even, odd, random, range, gcd, lcm } = prelude.number

suite 'even()' !->
    test 'validates even numbers' !->
        strictEqual (even 3), false
        strictEqual (even 2), true

suite 'odd()' !->
    test 'validates odd numbers' !->
        strictEqual (odd 2), false
        strictEqual (odd 3), true

suite 'random()' !->
    test 'generates a random number' !->
        isNumber (random 0, 5)

    test 'contains the full range' !->
        res1 = [(random 0, 5) for i til 100]
        res2 = [(random 5, 10) for i til 100]
        for i in [0 til 6]
            ok (i in res1)
        for i in [5 til 11]
            ok (i in res2)

    test 'one argument used as max' !->
        res1 = [(random 5) for i til 100]
        res2 = [(random 10) for i til 100]
        for i in [0 til 6]
            ok (i in res1)
        for i in [0 til 11]
            ok (i in res2)

suite 'range()' !->
    test 'creates an array' !->
        isArray (range 0, 5)

    test 'has the full range' !->
        deepEqual (range 0, 5), [0 1 2 3 4 5]
        deepEqual (range 5, 10), [5 6 7 8 9 10]

    test 'increases' !->
        deepEqual (range 0, 10, 2), [0 2 4 6 8 10]
        deepEqual (range 3, 10, 2), [3 5 7 9]
        deepEqual (range 0, 6, 3),  [0 3 6]

suite 'great()' !->
    test 'creates an array' !->
        isArray (range 0, 5)

    test 'has the full range' !->
        deepEqual (range 0, 5), [0 1 2 3 4 5]
        deepEqual (range 5, 10), [5 6 7 8 9 10]

    test 'increases' !->
        deepEqual (range 0, 10, 2), [0 2 4 6 8 10]
        deepEqual (range 3, 10, 2), [3 5 7 9]
        deepEqual (range 0, 6, 3),  [0 3 6]

suite 'gcd()' !->
    test 'curries' !->
        strictEqual 6, (18 |> gcd 12)

    test 'get greatest common denominator' !->
        strictEqual 6, gcd 12 18


suite 'lcm()' !->
    test 'curries' !->
        strictEqual 36, (18 |> lcm 12)

    test 'get least common multiple' !->
        strictEqual 36, lcm 12 18
