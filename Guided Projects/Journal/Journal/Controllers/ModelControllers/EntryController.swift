//
//  EntryController.swift
//  Journal
//
//  Created by Cameron Ingham on 7/12/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

class EntryController {
    
    static func create(title: String, body: String, isGoodDay: Bool){
        let _ = Entry(title: title, body: body, isGoodDay: isGoodDay)
        CoreDataStack.saveToPersistantStore()
    }
    
    static func delete(entry: Entry){
        CoreDataStack.context.delete(entry)
        CoreDataStack.saveToPersistantStore()
    }
    
    static func update(entry: Entry, title: String, body: String, isGoodDay: Bool){
        entry.title = title
        entry.body = body
        entry.isGoodDay = isGoodDay
        CoreDataStack.saveToPersistantStore()
    }
    
}
