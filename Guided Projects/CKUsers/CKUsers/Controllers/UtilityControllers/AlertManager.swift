//
//  AlertManager.swift
//  CKUsers
//
//  Created by Cameron Ingham on 8/8/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class AlertManager {
    
    // MARK: - Functions
    static func errorAlert(title: String = "Uh Oh", message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
    
}
