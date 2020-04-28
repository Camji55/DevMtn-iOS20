//
//  EntryTableViewController.swift
//  Journal
//
//  Created by Cameron Ingham on 7/4/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class EntryTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredEntries = [Entry]()
    
    var journal: Journal = Journal(title: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = journal.title
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Entries"
        searchController.searchBar.tintColor = UIColor.darkText
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        tableView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering() {
            return filteredEntries.count
        }
        
        return journal.entries.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? EntryTableViewCell
        let entry: Entry
        
        if isFiltering() {
            entry = filteredEntries[indexPath.section]
        } else {
            entry = journal.entries[indexPath.section]
        }
        
        let view = cell?.contentView.subviews[0]
        
        cell?.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        cell?.contentView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        view?.layer.cornerRadius = 4
        view?.layer.shadowColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1).cgColor
        view?.layer.shadowOffset = CGSize(width: 0, height: 1)
        view?.layer.shadowOpacity = 0.1
        view?.layer.shadowRadius = 5.0
        cell?.contentView.layer.masksToBounds = true

        cell?.titleLabel.text = entry.title
        cell?.timeStampLabel.text = entry.getDateString()
        cell?.bodyLabel.text = entry.bodyText
        cell?.tagLabel.text = entry.tag
        
        return cell!
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete Entry", message: "Are you sure you want to delete this entry?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (alert: UIAlertAction!) -> Void in
                if(self.isFiltering()){
                    let entry = self.filteredEntries[indexPath.section]
                    EntryController.deleteEntry(entry: entry, journal: self.journal)
                    self.searchController.searchResultsUpdater?.updateSearchResults(for: self.searchController)
                    
                }
                else{
                    let indexSet: IndexSet = IndexSet(arrayLiteral: indexPath.section)
                    let entry = self.journal.entries[indexPath.section]
                    EntryController.deleteEntry(entry: entry, journal: self.journal)
                    tableView.deleteSections(indexSet, with: .fade)
                    tableView.reloadData()
                }
                
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
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredEntries = journal.entries.filter({( entry : Entry) -> Bool in
            return entry.title.lowercased().contains(searchText.lowercased()) || entry.bodyText.lowercased().contains(searchText.lowercased()) || entry.tag.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToViewEntry" {
            guard let destinationVC = segue.destination as? ViewEntryViewController, let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            destinationVC.entry = journal.entries[indexPath.section]
        }
    }
    
    @IBAction func unwindToEntryList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddEntryViewController {
            let entryTitle = sourceViewController.entryTitle
            let entryTag = sourceViewController.entryTag
            let entryBody = sourceViewController.entryBody
            EntryController.createEntry(title: entryTitle, bodyText: entryBody, tag: entryTag, journal: self.journal)
        }
    }
}

extension EntryTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

