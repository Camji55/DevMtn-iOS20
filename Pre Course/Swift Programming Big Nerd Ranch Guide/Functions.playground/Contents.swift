//Bronze Challenge
func greetByMiddleName(fromFullName name: (first: String,
    middle: String?,
    last: String)) {
    guard let middleName = name.middle, middleName.count < 4 else{
        print("Hey there!")
        return
    }
    print("Hey \(middleName)")
}
greetByMiddleName(fromFullName: ("Matt","Danger","Mathias"))

//Silver Challenge
func siftBeans(fromGroceryList: [String]) -> (beans: [String], otherGroceries: [String]) {
    var beans: [String] = []
    var otherGroceries: [String] = []
    
    for groceryItem in fromGroceryList {
        if groceryItem.hasSuffix("beans"){
            beans.append(groceryItem)
        }
        else{
            otherGroceries.append(groceryItem)
        }
    }
    
    return (beans: beans, otherGroceries: otherGroceries)
}

let result = siftBeans(fromGroceryList: ["green beans", "milk", "black beans", "pinto beans", "apples"])

result.beans
result.otherGroceries
