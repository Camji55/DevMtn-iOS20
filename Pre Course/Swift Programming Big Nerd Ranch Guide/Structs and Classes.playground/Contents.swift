//: Bronze & Silver Challenge
struct Town {
    var population = 5422
    var numberOfStoplights = 4
    var vampires: [Vampire] = []
    
    func printDescription() {
        print("Population: \(population); number of stoplights: \(numberOfStoplights)")
    }
    mutating func changePopulation(by amount: Int) {
        population += amount
    }
}

class Monster {
    var town: Town?
    var name = "Monster"
    
    func terrorizeTown() {
        if town != nil {
            print("\(name) is terrorizing a town!")
        } else {
            print("\(name) hasn't found a town to terrorize yet...")
        }
    }
}

class Zombie: Monster {
    var walksWithLimp = true
    
    override func terrorizeTown() {
        if (town?.population)! >= 10 {
            town?.changePopulation(by: -10)
        }
        else {
            town?.changePopulation(by: (town?.population)!)
        }
        super.terrorizeTown()
    }
}

class ZombieBoss: Zombie {
    final override func terrorizeTown() {
        print("terrorizing town...")
    }
}

class Vampire: Monster {
    
    final override func terrorizeTown() {
        town?.vampires.append(self)
        if((town?.population)! > 0){
            town?.population -= 1
        }
        super.terrorizeTown()
    }
}
