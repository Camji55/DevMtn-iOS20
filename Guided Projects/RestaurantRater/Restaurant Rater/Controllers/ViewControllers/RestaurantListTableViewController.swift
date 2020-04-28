//
//  RestaurantListTableViewController.swift
//  Restaurant Rater
//
//  Created by Cameron Ingham on 7/14/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit
import CoreData

class RestaurantListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        RestaurantController.load()
        RestaurantController.fetchedResultsController.delegate = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RestaurantController.fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as? RestaurantTableViewCell else {return UITableViewCell()}
        let restaurant = RestaurantController.fetchedResultsController.object(at: indexPath)
        
        cell.restaurant = restaurant
        cell.delegate = self

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             let restaurant = RestaurantController.fetchedResultsController.object(at: indexPath)
            RestaurantController.delete(restaurant: restaurant)
        }
    }

    @IBAction func addRestaurant(_ sender: Any) {
        let alert = UIAlertController(title: "Add Restaurant", message: "Enter an restaurant name", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            if let text = textField.text?.trimmingCharacters(in: .whitespaces) {
                RestaurantController.create(name: text)
            }
        }
        let NoAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter name.."
        }
        
        alert.addAction(NoAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

extension RestaurantListTableViewController: RestaurantTableViewCellDelegate {
    func toggleButton(restaurant: Restaurant) {
        RestaurantController.toggleIsGood(restaurant: restaurant)
    }
}

extension RestaurantListTableViewController: NSFetchedResultsControllerDelegate {
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
