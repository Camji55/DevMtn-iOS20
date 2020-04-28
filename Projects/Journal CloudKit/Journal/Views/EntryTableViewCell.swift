//
//  EntryTableViewCell.swift
//  Journal
//
//  Created by Cameron Ingham on 7/4/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        bgView.layer.cornerRadius = 5
        bgView.layer.shadowColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1).cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 1)
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.shadowRadius = 5.0
        self.contentView.layer.masksToBounds = true
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    func updateViews(){
        guard let entry = entry else {return}
        titleLabel.text = entry.title
        timeStampLabel.text = entry.getDateString()
        bodyLabel.text = entry.bodyText
    }
    
}
