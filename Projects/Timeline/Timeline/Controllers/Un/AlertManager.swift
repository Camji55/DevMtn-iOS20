//
//  AlertManager.swift
//  Timeline
//
//  Created by Cameron Ingham on 8/8/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit
    
class AlertManager {

    // MARK: - Functions
    static func errorAlert(presentingViewController: UIViewController, title: String = "Uh oh", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        presentingViewController.present(alert, animated: true, completion: nil)
    }
    
    static func confirmAlert(presentingViewController: UIViewController, title: String = "Delete this post?", message: String = "You can't undo this!", confirmAction: UIAlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        presentingViewController.present(alert, animated: true, completion: nil)
    }
    
}
