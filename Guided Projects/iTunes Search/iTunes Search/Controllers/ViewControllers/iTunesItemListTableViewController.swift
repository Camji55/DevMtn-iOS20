//
//  iTunesItemListTableViewController.swift
//  iTunes Search
//
//  Created by Cameron Ingham on 7/19/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class iTunesItemListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var itunesItems = [iTunesItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itunesItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "iTunesItemCell") as? iTunesItemTableViewCell else {return UITableViewCell()}
        let iTunesItem = itunesItems[indexPath.row]
        
        cell.itunesItem = iTunesItem
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text?.trimmingCharacters(in: .whitespaces).lowercased(), !search.isEmpty else {return}
        self.search(search)
    }
    
    func search(_ term: String){
        print(term)
        iTunesItemController.getItunesItems(for: term) { (iTunesItems) in
            guard let iTunesItems = iTunesItems else {return}
            self.itunesItems = iTunesItems
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.searchBar.resignFirstResponder()
                self.searchBar.text = ""
            }
        }
    }

}
