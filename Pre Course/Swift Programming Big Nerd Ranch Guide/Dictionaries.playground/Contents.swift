//: Playground - noun: a place where people can play

import UIKit

//Silver

var washingtonZips = ["pierce": [98371, 98372, 98373, 98374, 98375],
                      "king": [98001, 98002, 98003, 98004, 98005],
                      "whitman": [99163, 99165, 99170, 99171, 99174]]

for zip in washingtonZips.values{
    print("\(zip), ")
}

//Gold
for counties in washingtonZips {
    print("\(counties.key): ")
    for zip in counties.value {
        print("\(zip), ")
    }
    print("\n")
}
