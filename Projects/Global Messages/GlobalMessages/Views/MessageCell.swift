//
//  MessageCell.swift
//  Post
//
//  Created by Cameron Ingham on 7/17/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    var message: Message?{
        didSet{
            updateViews()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    func updateViews(){
        guard let message = message else {return}
        nameLabel.text = message.username
        let date = Date(timeIntervalSince1970: message.timestamp)
        dateLabel.text = message.timeAgoSinceDate(date: date)
        messageLabel.text = message.text
    }
    
}
