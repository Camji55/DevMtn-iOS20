//
//  Restaurant+Convenience.swift
//  Restaurant Rater
//
//  Created by Cameron Ingham on 7/14/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CoreData

extension Restaurant {
    
    convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
    }
    
}
