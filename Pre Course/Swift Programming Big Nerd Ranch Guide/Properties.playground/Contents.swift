//: Bronze & Silver Challenge
struct Mayor {
    private var anxietyLevel: Int = 0
    mutating func populationDecrease() -> String {
        anxietyLevel += 1
        return "I'm deeply saddened to hear about this latest tragedy. I promise that my office is looking into the nature of this rash of violence."
    }
}

struct Town {
    var mayor: Mayor?
    static let region = "South"
    var population = 5422 {
        didSet(oldPopulation) {
            if(population < oldPopulation){
                print("The population has changed to \(population) from \(oldPopulation).")
                mayor?.populationDecrease()
            }
        }
    }
    var numberOfStoplights = 4
    var vampires: [Vampire] = []
    
    enum Size {
        case small
        case medium
        case large
    }
    
    var townSize: Size {
        get {
            switch self.population {
            case 0...10000:
                return Size.small
            
            case 10001...100000:
                return Size.medium
            
            default:
                return Size.large
            }
        }
    }

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
    static let isTerrifying = true
    
    class var spookyNoise: String {
        return "Grrr"
    }
    
    var victimPool: Int {
        get {
            return town?.population ?? 0
        }
        set(newVictimPool) {
            town?.population = newVictimPool
        }
    }
    
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
    
    override class var spookyNoise: String {
        return "Brains..."
    }
    
    private(set) var isFallingApart = false
    
    override func terrorizeTown() {
        if (town?.population)! >= 10 && !isFallingApart {
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






var myTown = Town()
let myTownSize = myTown.townSize
print(myTownSize)
myTown.changePopulation(by: 500)
print("Size: \(myTown.townSize); population: \(myTown.population)")
let fredTheZombie = Zombie()
fredTheZombie.town = myTown
fredTheZombie.terrorizeTown()
fredTheZombie.town?.printDescription()
print("Victim pool: \(fredTheZombie.victimPool)")
fredTheZombie.victimPool = 500
print("Victim pool: \(fredTheZombie.victimPool)")
print(Zombie.spookyNoise)
if Zombie.isTerrifying {
    print("Run away!")
}
