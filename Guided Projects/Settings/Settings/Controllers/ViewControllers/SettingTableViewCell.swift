//
//  SettingTableViewCell.swift
//  Settings
//
//  Created by Cameron Ingham on 7/9/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

protocol SettingTableViewCellDelegate: class {
    func switchTapped(cell: SettingTableViewCell)
}

class SettingTableViewCell: UITableViewCell {

    var setting: Setting? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: SettingTableViewCellDelegate?

    @IBOutlet weak var settingImageView: UIImageView!
    @IBOutlet weak var settingName: UILabel!
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    @IBAction func enabledSwitchedTapped(_ sender: Any) {
        delegate?.switchTapped(cell: self)
    }
    
    func updateViews(){
        guard let setting = setting else {return}
        self.settingImageView.image = setting.image
        self.settingName.text = setting.name
        self.toggleSwitch.isOn = setting.enabled
    }
}
