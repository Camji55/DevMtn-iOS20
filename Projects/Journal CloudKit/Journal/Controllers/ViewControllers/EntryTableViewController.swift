//
//  EntryTableViewController.swift
//  Journal
//
//  Created by Cameron Ingham on 7/4/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class EntryTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EntryController.shared.loadAll { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return EntryController.shared.entries.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? EntryTableViewCell else {return UITableViewCell()}
        let entry = EntryController.shared.entries.sorted(by: {$0.timeStamp < $1.timeStamp})[indexPath.section]
        
        cell.entry = entry
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete Entry", message: "Are you sure you want to delete this entry?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (alert: UIAlertAction!) -> Void in
                let indexSet: IndexSet = IndexSet(arrayLiteral: indexPath.section)
                let entry = EntryController.shared.entries.sorted(by: {$0.timeStamp < $1.timeStamp})[indexPath.section]
                EntryController.shared.delete(entry: entry, completion: { (success) in
                    DispatchQueue.main.async {
                        tableView.deleteSections(indexSet, with: .fade)
                        tableView.reloadData()
                    }
                })
            }
            let NoAction = UIAlertAction(title: "No", style: .default)
            
            alert.addAction(yesAction)
            alert.addAction(NoAction)
            
            present(alert, animated: true, completion:nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0{
            return CGFloat.leastNormalMagnitude
        }
        else {
            return 20
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToViewEntry" {
            guard let destinationVC = segue.destination as? ViewEntryViewController, let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            let entry = EntryController.shared.entries[indexPath.section]
            destinationVC.entry = entry
        }
    }
    
    @IBAction func unwindToEntryList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddEntryViewController {
            let entryTitle = sourceViewController.entryTitle
            let entryBody = sourceViewController.entryBody
            EntryController.shared.new(title: entryTitle, bodyText: entryBody) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}

