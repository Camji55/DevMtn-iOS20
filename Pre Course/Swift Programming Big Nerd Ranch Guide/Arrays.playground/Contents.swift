//: Playground - noun: a place where people can play

import UIKit

//Silver
var toDoList = ["Take out garbage", "Pay bills", "Cross off finished items"]
var toDoReversed: [String] = []
for x in 0...toDoList.count - 1{
    toDoReversed.append(toDoList[toDoList.count - 1 - x])
}

//Easier Way
let easyReverse = toDoList.reversed()


//Gold
var bucketList = ["Climb Mt. Everest"]
var newItems = [
    "Fly hot air balloon to Fiji",
    "Watch the Lord of the Rings trilogy in one day",
    "Go on a walkabout",
    "Scuba dive in the Great Blue Hole",
    "Find a triple rainbow"
]
bucketList += newItems
bucketList
bucketList.remove(at: 2)
print(bucketList.count)
print(bucketList[0...2])
bucketList[2] += " in Australia"
bucketList[0] = "Climb Mt. Kilimanjaro"
bucketList.insert("Toboggan across Alaska", at: 2)

let indexOfItem = bucketList.index(of: "Fly hot air balloon to Fiji")
if let item = indexOfItem {
    print(bucketList[item])
}
