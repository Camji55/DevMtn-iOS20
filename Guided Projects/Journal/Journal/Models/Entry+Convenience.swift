//
//  Entry+Convenience.swift
//  Journal
//
//  Created by Cameron Ingham on 7/12/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    convenience init(title: String, body: String, isGoodDay: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.body = body
        self.isGoodDay = isGoodDay
        self.timestamp = Date()
    }
}
