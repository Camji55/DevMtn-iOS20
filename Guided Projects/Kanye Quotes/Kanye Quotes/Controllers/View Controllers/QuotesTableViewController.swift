//
//  QuotesTableViewController.swift
//  Kanye Quotes
//
//  Created by Cameron Ingham on 7/12/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit
import CoreData

class QuotesTableViewController: UITableViewController {
    
    let fetchedRequestsController: NSFetchedResultsController<Quote> = {
        let request: NSFetchRequest<Quote> = Quote.fetchRequest()
        let quoteSort = NSSortDescriptor(key: "quote", ascending: true)
        request.sortDescriptors = [quoteSort]
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try fetchedRequestsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        fetchedRequestsController.delegate = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedRequestsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath) as? QuoteTableViewCell else {return UITableViewCell()}
        let quote = fetchedRequestsController.object(at: indexPath)
        
        cell.quote = quote

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let quote = fetchedRequestsController.object(at: indexPath)
            QuoteController.delete(quote: quote)
        }
    }
    
    @IBAction func addQuote(_ sender: Any) {
        let alert = UIAlertController(title: "Ye", message: "where's the quote", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            if let text = textField.text?.trimmingCharacters(in: .whitespaces) {
                QuoteController.create(quote: text, isKanye: true)
            }
        }
        let NoAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter quote.."
        }
        
        alert.addAction(NoAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? QuoteViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
        destinationVC.quote = fetchedRequestsController.object(at: indexPath)
    }

}

extension QuotesTableViewController: NSFetchedResultsControllerDelegate {
    
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


