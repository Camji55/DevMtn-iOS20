//
//  JournalsTableViewController.swift
//  Journal
//
//  Created by Cameron Ingham on 7/5/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class JournalsTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredJournals = [Journal]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).as1ptImage()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Journals"
        searchController.searchBar.tintColor = UIColor.darkText
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        JournalController.shared.loadJournals()
        tableView.reloadData()
        tableView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering() {
            return filteredJournals.count
        }
        
        return JournalController.shared.journals.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath) as? JournalTableViewCell
        let journal: Journal
        
        if isFiltering() {
            journal = filteredJournals[indexPath.section]
        } else {
            journal = JournalController.shared.journals[indexPath.section]
        }
        
        let view = cell?.contentView.subviews[0]
        
        cell?.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        view?.layer.cornerRadius = 4
        view?.layer.shadowColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1).cgColor
        view?.layer.shadowOffset = CGSize(width: 0, height: 1)
        view?.layer.shadowOpacity = 0.1
        view?.layer.shadowRadius = 5.0
        cell?.contentView.layer.masksToBounds = true

        
        cell?.titleLabel.text = journal.title
        var ending: String = ""
        if journal.entries.count == 1{
            ending = "Entry"
        } else {
            ending = "Entries"
        }
        
        cell?.entryLabel.text = "\(journal.entries.count) \(ending)"
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete Journal", message: "Are you sure you want to delete this journal?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (alert: UIAlertAction!) -> Void in
                if(self.isFiltering()){
                    let journal = self.filteredJournals[indexPath.section]
                    JournalController.shared.deleteJournal(journal: journal)
                    self.searchController.searchResultsUpdater?.updateSearchResults(for: self.searchController)
                } else {
                    JournalController.shared.deleteJournal(journal: JournalController.shared.journals[indexPath.section])
                    let indexSet: IndexSet = IndexSet(arrayLiteral: indexPath.section)
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
        filteredJournals = JournalController.shared.journals.filter({( journal : Journal) -> Bool in
            return journal.title.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToEntriesVC" {
            guard let destinationVC = segue.destination as? EntryTableViewController, let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            destinationVC.journal = JournalController.shared.journals[indexPath.section]
        }
    }
    
    @IBAction func addJournal(_ sender: Any) {
        let alert = UIAlertController(title: "Journal Name", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Create", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            if let text = textField.text?.trimmingCharacters(in: .whitespaces) {
                JournalController.shared.createJournal(title: text)
                self.tableView.reloadData()
            }
        }
        let NoAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter journal name"
        }
        
        alert.addAction(NoAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension JournalsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
