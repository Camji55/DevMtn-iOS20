//
//  TasksTableViewController.swift
//  Tasks
//
//  Created by Cameron Ingham on 7/11/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit
import CoreData

class TasksTableViewController: UITableViewController {

    var project: Project?
    
    var fetchedResultsController: NSFetchedResultsController<Task>?
    
    override func viewDidLoad() {
        
        guard let project = project else {return}
        fetchedResultsController = TaskController.fetchedResultsController(project: project)
        
        title = project.name
        do {
            try fetchedResultsController!.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        fetchedResultsController!.delegate = self
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController!.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 30, y: 19, width: tableView.frame.width - 60, height: 20))
        label.text = fetchedResultsController!.sections?[section].name == "0" ? "To Do" : "Completed"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController!.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskTableViewCell else {return UITableViewCell()}
        let task = fetchedResultsController!.object(at: indexPath)

        cell.task = task
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = fetchedResultsController!.object(at: indexPath)
            TaskController.deleteTask(task)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? TaskDetailViewController else {return}
        destinationVC.project = project
        if segue.identifier == "toDetailTask" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let task = fetchedResultsController!.object(at: indexPath)
            destinationVC.task = task
        }
    }
    
}

extension TasksTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .automatic)
        case .delete:
            tableView.deleteSections(indexSet, with: .automatic)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.reloadRows(at: [indexPath, newIndexPath], with: .automatic)
        }
    }
    
}
