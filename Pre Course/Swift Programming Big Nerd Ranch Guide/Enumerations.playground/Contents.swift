//Bronze & Silver Challenge
enum ShapeDimensions {
    // point has no associated value - it is dimensionless
    case point
    
    // square's associated value is the length of one side
    case square(side: Double)
    
    // rectangle's associated value defines its width and height
    case rectangle(width: Double, height: Double)
    
    // triangle's associated value defines its lengths of it's 3 sides
    case triangle(side1: Double, side2: Double, side3: Double)
    
    func area() -> Double {
        switch self {
        case .point:
            return 0
            
        case let .square(side: side):
            return side * side
            
        case let .rectangle(width: w, height: h):
            return w * h
        
        case let .triangle(side1: side1, side2: side2, side3: side3):
            return (side1 + side2 + side3) / 2
    
        }
    }
    
    func perimeter() -> Double {
        switch self {
        case .point:
            return 0
            
        case let .square(side: side):
            return side * 4
            
        case let .rectangle(width: w, height: h):
            return (w * 2) + (h * 2)
            
        case let .triangle(side1: side1, side2: side2, side3: side3):
            return side1 + side2 + side3
        }
    }
}
