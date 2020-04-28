//
//  HomeTableViewController.swift
//  CKUsers
//
//  Created by Cameron Ingham on 8/9/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEntries()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshEntries), for: .valueChanged)
        self.refreshControl = refreshControl
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - TableView Delegate & Data Source Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        let entry = EntryController.shared.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = "\(entry.timeStamp)"

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = EntryController.shared.entries[indexPath.row]
            EntryController.shared.deleteEntry(entry: entry) { (success) in
                DispatchQueue.main.async {
                    if success {
                        self.tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
            }
        }
    }

    // MARK: - Functions
    func loadEntries() {
        EntryController.shared.fetchEntries { (success) in
            DispatchQueue.main.async {
                if success {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    @objc func refreshEntries() {
        loadEntries()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEntryDetail" {
            guard let destination = segue.destination as? EntryDetailViewController, let indexPath = self.tableView.indexPathForSelectedRow else {return}
            
            destination.entry = EntryController.shared.entries[indexPath.row]
        }
    }

}
