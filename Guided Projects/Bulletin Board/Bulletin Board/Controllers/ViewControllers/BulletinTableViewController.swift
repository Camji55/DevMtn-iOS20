//
//  BulletinTableViewController.swift
//  Bulletin Board
//
//  Created by Cameron Ingham on 8/6/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit
import CloudKit

class BulletinTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var messageTextField: UITextField!
    
    // MARK: - Interactions
    @IBAction func postMessage(_ sender: UIButton) {
        guard let messageText = messageTextField.text?.trimmingCharacters(in: .whitespaces), !messageText.isEmpty else {
            return
        }
        MessageController.shared.post(with: messageText) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMessages()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshMessages), for: .valueChanged)
        self.refreshControl = refreshControl
    }

    // MARK: - Table View Delegate & Data Source Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageController.shared.messages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bulletinCell", for: indexPath)
        let message = MessageController.shared.messages.reversed()[indexPath.row]
        
        cell.textLabel?.text = message.messageText
        cell.detailTextLabel?.text = message.timeStamp.timeAgo()
        
        return cell
    }
    
    // MARK: - Functions
    func loadMessages() {
        MessageController.shared.loadAll { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    @objc func refreshMessages() {
        loadMessages()
    }
    
    

}
