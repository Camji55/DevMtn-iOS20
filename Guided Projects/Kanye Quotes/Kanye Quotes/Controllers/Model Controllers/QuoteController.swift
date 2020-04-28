//
//  QuoteController.swift
//  Kanye Quotes
//
//  Created by Cameron Ingham on 7/12/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CoreData

class QuoteController {
    
    static func create(quote: String, isKanye: Bool){
        let _ = Quote(quote: quote, isKanye: isKanye)
        CoreDataStack.saveToPersistantStore()
    }
    
    static func delete(quote: Quote){
        CoreDataStack.context.delete(quote)
        CoreDataStack.saveToPersistantStore()
    }
    
    static func update(quote: Quote, quoteString: String, isKanye: Bool){
        quote.quote = quoteString
        quote.isKanye = isKanye
        CoreDataStack.saveToPersistantStore()
    }
    
    static func toggleKanye(quote: Quote){
        quote.isKanye = !quote.isKanye
        CoreDataStack.saveToPersistantStore()
    }
    
}
