//
//  Project+Convenience.swift
//  Tasks
//
//  Created by Cameron Ingham on 7/11/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CoreData

extension Project {
    convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.name = name
        self.timestamp = Date()
    }
}
