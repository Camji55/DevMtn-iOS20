//
//  CategoriesTableViewController.swift
//  Chuck Norris Jokes
//
//  Created by Cameron Ingham on 7/18/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JokeController.getCategories { (categories) in
            if !categories.isEmpty {
                self.categories = categories
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                //Handle Error
            }
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.capitalized

        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? JokeViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
        destinationVC.category = categories[indexPath.row]
    }

}
