//
//  CoreDataManager.swift
//  MVC
//
//  Created by Cameron Ingham on 7/11/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static func saveToPersistantStore() {
        do {
            try CoreDataStack.managedObjectContext.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func delete(object: NSManagedObject){
        CoreDataStack.managedObjectContext.delete(object)
        saveToPersistantStore()
    }

}
