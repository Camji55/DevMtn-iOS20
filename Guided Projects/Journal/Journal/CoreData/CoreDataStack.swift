//
//  CoreDataStack.swift
//  Journal
//
//  Created by Cameron Ingham on 7/12/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let appName = Bundle.main.object(forInfoDictionaryKey: (kCFBundleNameKey as String)) as! String
        let container = NSPersistentContainer(name: appName)
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
    
    static func saveToPersistantStore(){
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
