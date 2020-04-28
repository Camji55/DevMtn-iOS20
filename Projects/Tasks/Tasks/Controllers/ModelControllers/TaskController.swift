//
//  TaskController.swift
//  Tasks
//
//  Created by Cameron Ingham on 7/11/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import UserNotifications
import CoreData

class TaskController {
    
    static func fetchedResultsController(project: Project) ->  NSFetchedResultsController<Task> {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let nameSort = NSSortDescriptor(key: "metaSort", ascending: true)
        fetchRequest.sortDescriptors = [nameSort]
        fetchRequest.predicate = NSPredicate(format: "project == %@", argumentArray: [project])
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
    }
    
    static func createTask(name: String, notes: String?, due: Date, completed: Bool = false, project: Project){
        let task = Task(name: name, notes: notes, due: due, project: project)
        CoreDataManager.saveToPersistantStore()
        scheduleUserNotifications(for: task)
    }
    
    static func deleteTask(_ task: Task){
        CoreDataManager.delete(object: task)
        CoreDataManager.saveToPersistantStore()
        cancelUserNotifications(for: task)
    }
    
    static func updateTask(task: Task, name: String, notes: String?, due: Date, completed: Bool = false, project: Project){
        task.name = name
        task.notes = notes
        task.due = due
        task.completed = completed
        task.project = project
        CoreDataManager.saveToPersistantStore()
        cancelUserNotifications(for: task)
        scheduleUserNotifications(for: task)
    }
    
    static func toggleComplete(task: Task){
        task.completed = !task.completed
        task.metaSort = task.completed ? "zzzzzzzzzzzz\(task.name!)" : "aaaaaaaaaaaa\(task.name!)"
        ProjectController.updateProject(project: task.project!, name: task.project!.name!)
        CoreDataManager.saveToPersistantStore()
    }

}

extension TaskController {
    
    private static func setCategories(){
        let noAction = UNNotificationAction(
            identifier: "dismiss",
            title: "Dismiss",
            options: []
        )
        let alarmCategory = UNNotificationCategory(
            identifier: "alarm.category",
            actions: [noAction],
            intentIdentifiers: [],
            options: [])
        UNUserNotificationCenter.current().setNotificationCategories([alarmCategory])
    }
    
    static func scheduleUserNotifications(for task: Task){
        setCategories()
        let content = UNMutableNotificationContent()
        content.title = task.project?.name ?? ""
        content.body = task.name ?? ""
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "alarm.category"
        let calendar = NSCalendar.current
        guard let due = task.due else {return}
        let dateComponents = calendar.dateComponents([.hour, .minute], from: due)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        guard let uuid = task.uuid else {return}
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    static func cancelUserNotifications(for task: Task){
        guard let uuid = task.uuid else {return}
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [uuid])
    }
}
