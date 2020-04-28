//: Playground - noun: a place where people can play

import UIKit

let range = (low: 1, high: 1000)

// If - Else
for x in range.low...range.high {
    if x % 3 == 0 && x % 5 != 0 {
        print("FIZZ")
    }
    else if x % 3 != 0 && x % 5 == 0 {
        print("BUZZ")
    }
    else if x % 3 == 0 && x % 5 == 0 {
        print("FIZZ BUZZ")
    }
    else {
        print(x)
    }
}

// Switch
for x in range.low...range.high {
    switch x{
        case _ where (x % 3 == 0 && x % 5 != 0):
            print("FIZZ")
        case _ where (x % 3 != 0 && x % 5 == 0):
            print("BUZZ")
        case _ where (x % 3 == 0 && x % 5 == 0):
            print("FIZZ BUZZ")
        default:
            print(x)
    }
}
