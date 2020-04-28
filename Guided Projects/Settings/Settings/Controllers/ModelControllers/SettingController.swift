//
//  SettingController.swift
//  Settings
//
//  Created by Cameron Ingham on 7/9/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class SettingController {
    
    static let shared = SettingController()
    
    var settings: [Setting] {
        let music = Setting(name: "iTunes", image: UIImage(named: "itunes")!)
        let appStore = Setting(name: "AppStore", image: UIImage(named: "app")!)
        let iBooks = Setting(name: "iBooks", image: UIImage(named: "ibooks")!)

        return [music, appStore, iBooks]
    }
    
    func changeToggle(setting: Setting){
        setting.enabled = !setting.enabled
    }
    
}
