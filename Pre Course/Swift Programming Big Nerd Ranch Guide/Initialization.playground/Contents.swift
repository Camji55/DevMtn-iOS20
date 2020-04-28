//: Silver & Gold Challenge - Incomplete
struct Mayor {
    private var anxietyLevel: Int = 0
    mutating func populationDecrease() -> String {
        anxietyLevel += 1
        return "I'm deeply saddened to hear about this latest tragedy. I promise that my office is looking into the nature of this rash of violence."
    }
}

struct Town {
    var mayor: Mayor?
    let region: String
    var population: Int {
        didSet(oldPopulation) {
            if(population < oldPopulation){
                print("The population has changed to \(population) from \(oldPopulation).")
                mayor?.populationDecrease()
            }
        }
    }
    var numberOfStoplights: Int
    var vampires: [Vampire] = []
    
    init?(region: String, population: Int, stoplights: Int) {
        guard population > 0 else {
            return nil
        }
        self.region = region
        self.population = population
        numberOfStoplights = stoplights
    }
    
    init?(population: Int, stoplights: Int) {
        self.init(region: "N/A", population: population, stoplights: stoplights)
    }
    
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
        print("Population: \(population); number of stoplights: \(numberOfStoplights); region: \(region)")
    }
    
    mutating func changePopulation(by amount: Int) {
        population += amount
    }
}

class Monster {
    var town: Town?
    var name: String
    static let isTerrifying = true
    
    class var spookyNoise: String {
        return "Grrr"
    }
    
    required init(town: Town?, monsterName: String) {
        self.town = town
        name = monsterName
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
    var walksWithLimp: Bool
    
    override class var spookyNoise: String {
        return "Brains..."
    }
    
    private(set) var isFallingApart: Bool
    
    init(limp: Bool, fallingApart: Bool, town: Town?, monsterName: String) {
        walksWithLimp = limp
        isFallingApart = fallingApart
        super.init(town: town, monsterName: monsterName)
    }
    
    convenience init(limp: Bool, fallingApart: Bool) {
        self.init(limp: limp, fallingApart: fallingApart, town: nil, monsterName: "Fred")
        if walksWithLimp {
            print("This zombie has a bad knee.")
        }
    }
    
    required init(town: Town?, monsterName: String) {
        walksWithLimp = false
        isFallingApart = false
        super.init(town: town, monsterName: monsterName)
    }
    
    deinit {
        print("Zombie named \(name) is no longer with us.")
    }
    
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






var myTown = Town(population: 1000, stoplights: 6)
myTown?.printDescription()
let myTownSize = myTown?.townSize
print(myTownSize!)
myTown?.changePopulation(by: 1000000)
print("Size: \(myTown!.townSize); population: \(myTown!.population)")
var fredTheZombie: Zombie? = Zombie(limp: false, fallingApart: false, town: myTown, monsterName: "Fred")
fredTheZombie?.terrorizeTown()
fredTheZombie?.town?.printDescription()

var convenientZombie = Zombie(limp: true, fallingApart: false)

print("Victim pool: \(fredTheZombie!.victimPool)")
fredTheZombie?.victimPool = 500
print("Victim pool: \(fredTheZombie!.victimPool)")
print(Zombie.spookyNoise)
if Zombie.isTerrifying {
    print("Run away!")
}
fredTheZombie = nil

