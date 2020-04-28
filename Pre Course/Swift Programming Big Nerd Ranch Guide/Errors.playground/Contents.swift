// Bronze and Silver and Gold Challenges
enum Token: Equatable{
    enum Error: Swift.Error {
        case tokenHasNoNumberValue(Token)
    }
    
    case number(value: Int, atPosition: Int)
    case plus(atPosition: Int)
    case minus(atPosition: Int)
    case multiplication(atPosition: Int)
    case division(atPosition: Int)
    
    func getNumber() throws -> Int {
        switch self {
        case .number(let value, _):
            return value
        default:
            throw Token.Error.tokenHasNoNumberValue(self)
        }
    }
    
    func getPosition() -> Int {
        switch self {
        case .number(_, let position):
            return position
        case .plus(let position), .minus(let position), .multiplication(let position), .division(let position):
            return position
        }
    }
    
    static func == (lhs: Token, rhs: Token) -> Bool {
        return lhs.getPosition() == rhs.getPosition()
    }
}

class Lexer {
    enum Error: Swift.Error {
        case invalidCharacter(Character, Int)
    }
    
    let input: String.CharacterView
    var position: String.CharacterView.Index
    
    init(input: String) {
        self.input = input.characters
        self.position = self.input.startIndex
    }
    
    func peek() -> Character? {
        guard position < input.endIndex else {
            return nil
        }
        return input[position]
    }
    
    func advance() {
        assert(position < input.endIndex, "Cannot advance past endIndex!")
        position = input.index(after: position)
    }
    
    func getNumber() -> Int {
        var value = 0
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0" ... "9":
                let digitValue = Int(String(nextCharacter))!
                value = 10 * value + digitValue
                advance()
            default:
                return value
            }
        }
        return value
    }
    
    func lex() throws -> [Token] {
        var tokens = [Token]()
        while let nextCharacter = peek() {
            let atPosition = input.distance(from: input.startIndex, to: position)
            switch nextCharacter {
            case "0" ... "9":
                let token = Token.number(value: getNumber(), atPosition: atPosition)
                tokens.append(token)
            case "+":
                tokens.append(.plus(atPosition: atPosition))
                advance()
            case "-":
                tokens.append(.minus(atPosition: atPosition))
                advance()
            case "*":
                tokens.append(.multiplication(atPosition: atPosition))
                advance()
            case "/":
                tokens.append(.division(atPosition: atPosition))
                advance()
            case " ":
                advance()
            default:
                throw Lexer.Error.invalidCharacter(nextCharacter, atPosition)
            }
        }
        return tokens
    }
}

class Parser {
    enum Error: Swift.Error {
        case unexpectedEndOfInput
        case invalidToken(Token)
        case failedToIdentifyTokenIndex(Token)
    }
    
    var tokens: [Token]
    var position = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    func getNextToken() -> Token? {
        guard position < tokens.count else {
            return nil
        }
        let token = tokens[position]
        position += 1
        return token
    }
    
    func reset() {
        position = 0
    }
    
    func firstCompoundExpressionOperatorIndex() -> Int? {
        for var i in 0 ..< tokens.count {
            switch tokens[i] {
            case .division, .multiplication:
                return i;
            default:
                i += 1
            }
        }
        return nil
    }
    
    func getNumberToken() throws -> Token {
        guard let token = getNextToken() else {
            throw Parser.Error.unexpectedEndOfInput
        }
        switch token {
        case .number:
            return token
        case .plus, .minus, .multiplication, .division:
            throw Parser.Error.invalidToken(token)
        }
    }
    
    func parse() throws -> Int {
        func getCompoundToken(operationToken token: Token) throws -> (left: Token, operation: Token, right: Token) {
            var leftToken: Token
            var rightToken: Token
            
            if let tokenIndex = tokens.index(of: token) {
                let leftTokenIndex = tokens.index(before: tokenIndex)
                let rightTokenIndex = tokens.index(after: tokenIndex)
                
                if (leftTokenIndex >= tokens.startIndex) {
                    leftToken = tokens[leftTokenIndex]
                } else {
                    throw Parser.Error.invalidToken(token)
                }
                
                if (rightTokenIndex < tokens.endIndex) {
                    rightToken = tokens[rightTokenIndex]
                } else {
                    throw Parser.Error.invalidToken(token)
                }
            } else {
                throw Parser.Error.invalidToken(token)
            }
            return (leftToken, token, rightToken)
        }
        
        func evaluateCompoundValue(_ compoundToken: (left: Token, operation: Token, right: Token)) throws -> Int {
            let leftNumber = try compoundToken.left.getNumber()
            var value = leftNumber
            switch compoundToken.operation {
            case .division:
                let rightNumber = try compoundToken.right.getNumber()
                value /= rightNumber
            case .multiplication:
                let rightNumber = try compoundToken.right.getNumber()
                value *= rightNumber
            default:
                throw Parser.Error.invalidToken(compoundToken.operation)
            }
            return value
        }
        
        while let compoundOperatorIndex = firstCompoundExpressionOperatorIndex() {
            let compoundToken = try getCompoundToken(operationToken: tokens[compoundOperatorIndex])
            let compoundTokenValue = try evaluateCompoundValue(compoundToken)
            let leftTokenIndex = tokens.index(before: compoundOperatorIndex)
            let rightTokenIndex = tokens.index(after: compoundOperatorIndex)
            let leftTokenPosition = tokens[leftTokenIndex].getPosition()
            
            tokens[leftTokenIndex] = Token.number(value: compoundTokenValue, atPosition: leftTokenPosition)
            tokens.removeSubrange(compoundOperatorIndex...rightTokenIndex)
            reset()
        }
        
        let firstNumberValue = try getNumberToken().getNumber()
        
        var value = firstNumberValue
        
        while let token = getNextToken() {
            switch token {
            case .plus:
                let nextNumberTokenValue = try getNumberToken().getNumber()
                value += nextNumberTokenValue
            case .minus:
                let nextNumberTokenValue = try getNumberToken().getNumber()
                value -= nextNumberTokenValue
            case .number, .division, .multiplication:
                throw Parser.Error.invalidToken(token)
            }
        }
        return value
    }
}

func evaluate(_ input: String) {
    print("Evaluating \(input)")
    let lexer = Lexer(input: input)
    
    do {
        let tokens = try lexer.lex()
        print("Lexer output: \(tokens)")
        
        let parser = Parser(tokens: tokens)
        let result = try parser.parse()
        print("Parser output: \(result)")
    } catch Lexer.Error.invalidCharacter(let character, let position) {
        print("Input contained an invalid character at index \(position) : \(character)")
    } catch Parser.Error.unexpectedEndOfInput {
        print("Unexpected end of input during parsing.")
    } catch Parser.Error.invalidToken(let token) {
        let tokenPosition: Int
        switch token {
        case .minus(let position), .number(_, let position), .plus(let position), .division(let position), .multiplication(let position):
            tokenPosition = position
            print("Invalid token during parsing at index \(tokenPosition): \(token)")
        }
    } catch {
        print("An error occurred: \(error)")
    }
}

evaluate("10 + 3 + 5")
evaluate("10 + 5 - 3 - 1")
evaluate("1 + 3 + 7a + 8")
evaluate("6 * 2 + 1 / 5")
