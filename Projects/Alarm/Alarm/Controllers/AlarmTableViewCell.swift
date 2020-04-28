//
//  AlarmTableViewCell.swift
//  Alarm
//
//  Created by Cameron Ingham on 7/9/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

protocol AlarmTableViewCellDelegate: class {
    func toggleChanged(cell: AlarmTableViewCell)
}

class AlarmTableViewCell: UITableViewCell {
    
    var alarm: Alarm? {
        didSet{
            updateViews()
        }
    }
    
    weak var delegate: AlarmTableViewCellDelegate?

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var hrLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var toggle: UISwitch!
    
    @IBAction func toggled(_ sender: Any) {
        delegate?.toggleChanged(cell: self)
    }
    
    func updateViews(){
        guard let alarm = alarm else { return }
        self.nameLabel.text = alarm.name
        self.timeLabel.text = DateController.time(date: alarm.date).time
        self.hrLabel.text = DateController.time(date: alarm.date).hr
        self.toggle.isOn = alarm.toggle
    }

}
