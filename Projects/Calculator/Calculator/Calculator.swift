//
//  CalculatorManager.swift
//  Calculator
//
//  Created by Cameron Ingham on 8/14/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

class Calculator {
    
    // MARK: - Functions
    func calculate(expressionString: String?) -> Double? {
        guard let expressionString = expressionString?.replacingOccurrences(of: "x", with: "*").replacingOccurrences(of: " ", with: "").trimmingCharacters(in: .whitespaces) else {
            return nil
        }
        
        let expression = NSExpression(format: expressionString)
        if let result = expression.expressionValue(with: nil, context: nil) as? Double {
            return result
        } else {
            return nil
        }

    }
    
}
