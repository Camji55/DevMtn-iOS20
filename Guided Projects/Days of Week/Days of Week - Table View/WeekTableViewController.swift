//
//  WeekTableViewController.swift
//  Days of Week - Table View
//
//  Created by Cameron Ingham on 7/3/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class WeekTableViewController: UITableViewController {
    
    //Days of the week
    var daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfWeek.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeekCell", for: indexPath)
        let day = daysOfWeek[indexPath.row]
        
        cell.textLabel?.text = day
        cell.detailTextLabel?.text = String(indexPath.row)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ToDetailVC"){
            guard let detailViewController = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else{ return }
            detailViewController.day = daysOfWeek[indexPath.row]
        }
    }
}
