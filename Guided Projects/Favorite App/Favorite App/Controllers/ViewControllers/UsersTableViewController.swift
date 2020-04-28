//
//  UsersTableViewController.swift
//  Favorite App
//
//  Created by Cameron Ingham on 7/18/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        loadData()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserController.shared.users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = UserController.shared.users[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.favoriteApp

        return cell
    }
    
    @IBAction func addUser(_ sender: Any) {
        let alert = UIAlertController(title: "Add a new user", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textfield) in
            textfield.placeholder = "Enter a username..."
        }
        
        alert.addTextField { (textfield) in
            textfield.placeholder = "Enter your favorite app..."
        }
        
        let okayAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let username = alert.textFields?[0].text?.trimmingCharacters(in: .whitespaces), !username.isEmpty,
                let favoriteApp = alert.textFields?[1].text?.trimmingCharacters(in: .whitespaces), !favoriteApp.isEmpty else {return}
            UserController.shared.addUsers(username: username, favoriteApp: favoriteApp, completion: { (success) in
                if success {
                    self.loadData()
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(okayAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadData(){
        UserController.shared.getUsers { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
