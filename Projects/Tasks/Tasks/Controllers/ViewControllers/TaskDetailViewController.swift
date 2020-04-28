//
//  TaskDetailViewController.swift
//  Tasks
//
//  Created by Cameron Ingham on 7/14/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var duePicker: UIDatePicker!
    
    var project: Project?
    var task: Task? {
        didSet{
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = task == nil ? "Add Task" : "Edit Task"
        duePicker.minimumDate = Date()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func save(_ sender: Any) {
        if task == nil {
            guard let name = nameTextField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty, let project = project else {return}
            TaskController.createTask(name: name, notes: nil, due: duePicker.date, project: project)
            navigationController?.popViewController(animated: true)
        } else {
            guard let name = nameTextField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty, let task = task, let project = project else {return}
            TaskController.updateTask(task: task, name: name, notes: nil, due: duePicker.date, project: project)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func updateViews(){
        guard let task = task else {return}
        self.nameTextField.text = task.name
        self.duePicker.date = task.due!
    }
    
}
