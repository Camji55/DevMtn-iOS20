//
//  TaskTableViewCell.swift
//  Tasks
//
//  Created by Cameron Ingham on 7/11/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    var task: Task? {
        didSet{
            updateViews()
        }
    }

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var completedButton: UIButton!
    
    override func awakeFromNib() {
        bgView.layer.cornerRadius = 5
        bgView.layer.shadowColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1).cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 1)
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.shadowRadius = 5.0
        self.contentView.layer.masksToBounds = true
    }
    
    @IBAction func completedTapped(_ sender: Any) {
        guard let task = task else {return}
        TaskController.toggleComplete(task: task)
        updateViews()
    }
    
    func updateViews(){
        guard let task = task, let name = task.name else {return}
        if task.completed {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: name)
            attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            self.nameLabel.attributedText = attributeString
            self.nameLabel.textColor = UIColor.lightGray
        } else {
            self.nameLabel.attributedText = nil
            self.nameLabel.text = name
            self.nameLabel.textColor = UIColor.darkText
        }
        let image = task.completed ? UIImage(named: "checked") : UIImage(named: "unchecked")
        self.completedButton.setBackgroundImage(image, for: .normal)
    }
    
}
