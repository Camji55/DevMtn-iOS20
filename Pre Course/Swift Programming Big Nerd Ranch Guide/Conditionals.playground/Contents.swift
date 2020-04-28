//: Playground - noun: a place where people can play

import UIKit

var population: Int = 40640
var message: String
var hasPostOffice: Bool = true

if population < 10000 {
    message = "\(population) is a small town!"
}
else if population >= 10000 && population < 50000{
    message = "\(population) is a medium town!"
}
else if population >= 50000 && population < 100000{
    message = "\(population) is pretty big!"
}
else{
    message = "\(population) is very big!"
}

print(message)

if !hasPostOffice {
    print("Where do we buy stamps?")
}
