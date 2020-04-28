//
//  ProjectsTableViewController.swift
//  Tasks
//
//  Created by Cameron Ingham on 7/11/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit
import CoreData

class ProjectsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try ProjectController.fetchedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        ProjectController.fetchedResultsController.delegate = self
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProjectController.fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as? ProjectTableViewCell else {return UITableViewCell()}
        let project = ProjectController.fetchedResultsController.object(at: indexPath)
        
        cell.project = project
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let project = ProjectController.fetchedResultsController.object(at: indexPath)
            ProjectController.deleteProject(project)
        }
    }
    
    @IBAction func addProject(_ sender: Any) {
        let alert = UIAlertController(title: "Project Name", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Create", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            if let text = textField.text?.trimmingCharacters(in: .whitespaces) {
                ProjectController.createProject(name: text)
            }
        }
        let NoAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter project name..."
            textField.autocapitalizationType = .words
        }
        
        alert.addAction(NoAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskVC" {
            guard let destinationVC = segue.destination as? TasksTableViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            let project = ProjectController.fetchedResultsController.object(at: indexPath)
            destinationVC.project = project
        }
    }
    
}

extension ProjectsTableViewController: NSFetchedResultsControllerDelegate {
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
