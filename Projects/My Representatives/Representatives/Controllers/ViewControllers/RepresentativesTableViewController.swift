//
//  RepresentativesTableViewController.swift
//  Representatives
//
//  Created by Cameron Ingham on 7/19/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class RepresentativesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var representatives = [Representative]()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return representatives.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepresentativeCell", for: indexPath)
        let representative = representatives[indexPath.row]
        
        cell.textLabel?.text = representative.name
        cell.detailTextLabel?.text = representative.party

        return cell
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let zip = searchBar.text?.trimmingCharacters(in: .whitespaces), !zip.isEmpty else {return}
        load(zip: zip)
    }
    
    func load(zip: String){
        RepresentativeController.getRepresentatives(fromZip: zip) { (representatives) in
            DispatchQueue.main.async {
                guard let representatives = representatives else {return}
                self.representatives = representatives
                self.tableView.reloadData()
                self.searchBar.resignFirstResponder()
                self.title = "\(zip) Reps."
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? RepresentativeDetailTableViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
        destinationVC.representative = representatives[indexPath.row]
    }

}
