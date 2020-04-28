//
//  Task+Convenience.swift
//  Tasks
//
//  Created by Cameron Ingham on 7/11/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    convenience init(name: String, notes: String?, due: Date, completed: Bool = false, project: Project, context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.uuid = generateUUID()
        self.name = name
        self.notes = notes
        self.due = due
        self.completed = completed
        self.project = project
        self.timestamp = Date()
        self.metaSort = completed ? "aaaaaaaaaaaaaaaaaa\(name)" : "zzzzzzzzzzzzzzzzzz\(name)"
    }
    
    func dateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        guard let date = self.due else {return ""}
        return formatter.string(from: date)
    }
    
    private func generateUUID() -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< len {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
}
