//
//  LoadingViewController.swift
//  Timeline
//
//  Created by Cameron Ingham on 8/9/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    // MARK: - Properties
    var runCounter = 0

    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        CloudKitManager.cloudKitAvailability { (available) in
            if !available {
                AlertManager.errorAlert(presentingViewController: self, message: "iCloud account not accessable. Login to iCloud in the Settings app.")
            } else {
                PostController.shared.loadPosts { (success, error) in
                    DispatchQueue.main.async {
                        if let error = error {
                            AlertManager.errorAlert(presentingViewController: self, message: error)
                        } else {
                            if(self.runCounter == 0) {
                                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainApp") as UIViewController
                                self.present(viewController, animated: true, completion: nil)
                                self.runCounter += 1
                            }
                        }
                    }
                }
            }
        }
    }
    
}
