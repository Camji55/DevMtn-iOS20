//
//  ProjectController.swift
//  Tasks
//
//  Created by Cameron Ingham on 7/11/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CoreData

class ProjectController {
    
    static let fetchedResultsController: NSFetchedResultsController<Project> = {
        let fetchRequest: NSFetchRequest<Project> = Project.fetchRequest()
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [nameSort]
        fetchRequest.predicate = NSPredicate(value: true)
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    static func createProject(name: String){
        let _ = Project(name: name)
        CoreDataManager.saveToPersistantStore()
    }
    
    static func deleteProject(_ project: Project){
        CoreDataManager.delete(object: project)
    }
    
    static func updateProject(project: Project, name: String){
        project.name = name
        CoreDataManager.saveToPersistantStore()
    }
    
}
