//
//  RestaurantController.swift
//  Restaurant Rater
//
//  Created by Cameron Ingham on 7/14/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CoreData

class RestaurantController {
    static let  fetchedResultsController: NSFetchedResultsController<Restaurant> = {
        let request: NSFetchRequest = Restaurant.fetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    static func create(name: String){
        let _ = Restaurant(name: name)
        save()
    }
    
    static func delete(restaurant: Restaurant){
        CoreDataStack.context.delete(restaurant)
        save()
    }
    
    static func toggleIsGood(restaurant: Restaurant){
        restaurant.isGood = !restaurant.isGood
        save()
    }
    
    static func save(){
        do {
            try CoreDataStack.context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func load(){
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
