//
//  ViewController.swift
//  Post
//
//  Created by Cameron Ingham on 7/16/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var messages: [Message] = []
    var username: String = "anonymous"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        askUsername(completion: { (username) in
            self.username = username
        })
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        self.refreshControl = refreshControl
        handleRefresh(refreshControl)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? MessageCell else {return UITableViewCell()}
        let message = messages[indexPath.row]
        
        cell.message = message
        
        return cell
    }
    
    @IBAction func addPost(_ sender: Any) {
        let alert = UIAlertController(title: "Add a Message", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            let textTextField = alert.textFields![0] as UITextField
            guard let text = textTextField.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty else { return }
            let newMessage = Message(text: text, timestamp: Date().timeIntervalSince1970, username: self.username)
            MessageController.create(message: newMessage, completion: { _ in })
            guard let refresh = self.refreshControl else {return}
            self.handleRefresh(refresh)
        }
        let NoAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addTextField { (textTextField) in
            textTextField.placeholder = "Enter message"
        }
        
        alert.addAction(NoAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func askUsername(completion: @escaping (String) -> Void){
        let alert = UIAlertController(title: "Enter Username", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Next", style: .default) { (alertAction) in
            let usernameTextField = alert.textFields![0] as UITextField
            guard let myUsername = usernameTextField.text?.trimmingCharacters(in: .whitespaces), !myUsername.isEmpty else { return }
            completion(myUsername)
        }
        alert.addTextField { (usernameTextField) in
            usernameTextField.placeholder = "Enter a username..."
            usernameTextField.autocapitalizationType = .words
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.tintColor = UIColor.white
        MessageController.messages { (messages, success) in
            if success{
                guard let messages = messages else {return}
                let sortedmessages = messages.sorted(by: { (post1, post2) -> Bool in
                    return post1.timestamp < post2.timestamp
                })
                self.messages = sortedmessages
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    refreshControl.endRefreshing()
                }
            }
        }
    }
}

