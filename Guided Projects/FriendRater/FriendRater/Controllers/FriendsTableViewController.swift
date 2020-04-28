//
//  FriendsTableViewController.swift
//  FriendRater
//
//  Created by Cameron Ingham on 7/7/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        FriendController.shared.loadFriends()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendController.shared.friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        let friend = FriendController.shared.friends[indexPath.row]
        
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = String(friend.rating)

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let friend = FriendController.shared.friends[indexPath.row]
            FriendController.shared.deleteFriend(friend: friend)
            tableView.reloadData()
            FriendController.shared.saveFriends()
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? FriendDetailViewController else{
            return
        }
        if(segue.identifier == "ToFriendDetail"){
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.friend = FriendController.shared.friends[indexPath.row]
            }
        }
    }
}
