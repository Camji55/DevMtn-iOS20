//
//  ViewAlarmTableViewController.swift
//  Alarm
//
//  Created by Cameron Ingham on 7/9/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class ViewAlarmTableViewController: UITableViewController {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var alarmName: UILabel!
    @IBOutlet weak var enabled: UISwitch!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var alarm: Alarm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alert = UIAlertController(title: "Alarm Name", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Create", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            if let text = textField.text?.trimmingCharacters(in: .whitespaces) {
                self.alarmName.text = text
                tableView.reloadData()
            }
        }
        let NoAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter alarm name"
        }
        
        alert.addAction(NoAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func updateViews(){
        if let name = alarm?.name, let date = alarm?.date, let enabled = alarm?.toggle {
            self.alarmName.text = name
            self.timePicker.date = date
            self.enabled.isOn = enabled
        }
    }
    
    @IBAction func done(_ sender: Any) {
        guard let name = alarmName.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else {
            let alert = UIAlertController(title: "Uh oh", message: "You need to set a alarm name in order to save it.", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "Okay", style: .default)

            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
            return
        }
        if(alarm == nil){
            AlarmController.shared.addAlarm(name: name, date: timePicker.date)
            navigationController?.popViewController(animated: true)
        } else {
            AlarmController.shared.update(alarm: alarm!, name: name, date: timePicker.date, toggle: enabled.isOn)
            navigationController?.popViewController(animated: true)
        }
    }
    
}
