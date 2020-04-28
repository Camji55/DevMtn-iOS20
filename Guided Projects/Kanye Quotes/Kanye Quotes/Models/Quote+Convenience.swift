//
//  Quote+Convenience.swift
//  Kanye Quotes
//
//  Created by Cameron Ingham on 7/12/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CoreData

extension Quote {
    convenience init(quote: String, isKanye: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.quote = quote
        self.isKanye = isKanye
    }
}
