//
//  AlarmTableController.swift
//  Alarm
//
//  Created by Cameron Ingham on 7/9/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class AlarmTableController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        AlarmController.shared.loadAlarms()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "AlarmCell") as? AlarmTableViewCell else { return UITableViewCell()}
        
        cell.alarm = AlarmController.shared.alarms[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete Alarm", message: "Are you sure you want to delete this alarm?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (alert: UIAlertAction!) -> Void in
                AlarmController.shared.deleteAlarm(alarm: AlarmController.shared.alarms[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }
            let NoAction = UIAlertAction(title: "No", style: .default)
            
            alert.addAction(yesAction)
            alert.addAction(NoAction)
            
            present(alert, animated: true, completion:nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toViewAlarm" {
            guard let destinationVC = segue.destination as? ViewAlarmTableViewController, let indexPath = self.tableView.indexPathForSelectedRow else { return }
            destinationVC.alarm = AlarmController.shared.alarms[indexPath.row]
        }
    }
    
}

extension AlarmTableController: AlarmTableViewCellDelegate {
    func toggleChanged(cell: AlarmTableViewCell) {
        guard let alarm = cell.alarm else { return }
        AlarmController.shared.changeToggle(alarm: alarm)
    }
}
