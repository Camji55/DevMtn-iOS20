//Silver Challenge Incomplete & Gold Challenge
protocol TabularDataSource {
    var numberOfRows: Int { get }
    var numberOfColumns: Int { get }
    
    func label(forColumn column: Int) -> String
    
    func itemFor(row: Int, column: Int) -> String
}


func printTable(_ dataSource: TabularDataSource & CustomStringConvertible) {
    print("Table: \(dataSource.description)")
    
    // Create first row containing column headers
    var firstRow = "|"
    
    // Also keep track of the width of each column
    var columnWidths = [Int]()
    
    for i in 0 ..< dataSource.numberOfColumns {
        let columnLabel = dataSource.label(forColumn: i)
        let columnHeader = " \(columnLabel) |"
        firstRow += columnHeader
        columnWidths.append(columnLabel.characters.count)
    }
    print(firstRow)
    
    for _ in 0 ..< dataSource.numberOfRows {
        // Start the output string
        _ = "|"
        
        // Append each item in this row to the string
        for i in 0 ..< dataSource.numberOfRows {
            var out = "|"
            for j in 0 ..< dataSource.numberOfColumns {
                let item = dataSource.itemFor(row: i, column: j)
                let paddingNeeded = columnWidths[j] - item.characters.count
                let padding = repeatElement(" ", count:
                    paddingNeeded).joined(separator: "")
                out += " \(padding)\(item) |"
            }
            
            // Done - print it!
            print(out)
        }
    }
}

struct Person {
    let name: String
    let age: Int
    let yearsOfExperience: Int
}

struct Department: TabularDataSource, CustomStringConvertible {
    let name: String
    var people = [Person]()
    
    var description: String {
        return "Department (\(name))"
    }
    
    
    init(name: String) {
        self.name = name
    }
    
    mutating func add(_ person: Person) {
        people.append(person)
    }
    
    var numberOfRows: Int {
        return people.count
    }
    
    var numberOfColumns: Int {
        return 3
    }
    
    func label(forColumn column: Int) -> String {
        switch column {
        case 0: return "Employee Name"
        case 1: return "Age"
        case 2: return "Years of Experience"
        default: fatalError("Invalid column!")
        }
    }
    
    func itemFor(row: Int, column: Int) -> String {
        let person = people[row]
        switch column {
        case 0: return person.name
        case 1: return String(person.age)
        case 2: return String(person.yearsOfExperience)
        default: fatalError("Invalid column!")
        }
    }
}

struct Book {
    var title: String
    var author: String
    var amazonReview: Double
}

struct BookCollection: TabularDataSource, CustomStringConvertible {
    
    var description: String
    
    var books = [Book]()
    
    var numberOfRows: Int {
        return books.count
    }
    
    var numberOfColumns: Int {
        return 3
    }
    
    func label(forColumn column: Int) -> String {
        switch column {
        case 0: return "Title"
        case 1: return "Author"
        case 2: return "Amazon Review"
        default: fatalError("Invalid column!")
        }
    }
    
    func itemFor(row: Int, column: Int) -> String {
        let book = books[row]
        switch column {
        case 0: return book.title
        case 1: return String(book.author)
        case 2: return String(book.amazonReview)
        default: fatalError("Invalid column!")
        }
    }
    
}

var department = Department(name: "Engineering")
department.add(Person(name: "Joe", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Karen", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Fred", age: 50, yearsOfExperience: 20))

printTable(department)
