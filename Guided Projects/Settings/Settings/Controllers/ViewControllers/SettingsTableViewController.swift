//
//  SettingsTableViewController.swift
//  Settings
//
//  Created by Cameron Ingham on 7/9/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingController.shared.settings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setting = SettingController.shared.settings[indexPath.row]
        cell.delegate = self
        return cell
    }
    
}

extension SettingsTableViewController: SettingTableViewCellDelegate {
    func switchTapped(cell: SettingTableViewCell) {
        guard let setting = cell.setting else { return }
        SettingController.shared.changeToggle(setting: setting)
        if(cell.toggleSwitch.isOn){
            cell.backgroundColor = UIColor.lightGray
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
}
