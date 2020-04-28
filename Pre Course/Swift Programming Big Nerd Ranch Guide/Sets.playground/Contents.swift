var myCities = Set(["Atlanta", "Chicago", "Jacksonville", "New York", "San Francisco"])
var yourCities = Set(["Chicago", "Jacksonville", "San Francisco"])

//Bronze Challenge

yourCities.isStrictSubset(of: myCities)

//Silver Challenge
myCities.insert("Seattle")
yourCities.insert("Salt Lake City")
myCities.formUnion(yourCities)
myCities.formIntersection(yourCities)
