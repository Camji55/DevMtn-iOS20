//
//  ProjectTableViewCell.swift
//  Tasks
//
//  Created by Cameron Ingham on 7/14/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    
    var project: Project? {
        didSet{
            updateViews()
        }
    }

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var numOfTasks: UILabel!
    
    
    override func awakeFromNib() {
        bgView.layer.cornerRadius = 5
        bgView.layer.shadowColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1).cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 1)
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.shadowRadius = 5.0
        self.contentView.layer.masksToBounds = true
    }

    
    func updateViews(){
        guard let project = project else {return}
        
        var tasks: [Task]? {
            guard let allTasks = project.tasks?.allObjects as? [Task] else {return []}
            let tasks = allTasks.filter { (task) -> Bool in
                return task.completed != true
            }
            return tasks
        }
        
        guard let completedTasks = tasks else {return}
        
        self.projectName.text = project.name
        self.numOfTasks.text = completedTasks.count != 1 ? "\(completedTasks.count) tasks" : "\(completedTasks.count) task"
    }
    
}
