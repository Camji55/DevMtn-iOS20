//
//  LoadingScreenViewController.swift
//  CKUsers
//
//  Created by Cameron Ingham on 8/8/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class LoadingScreenViewController: UIViewController {

    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        UserController.shared.fetch { (success, _) in
            DispatchQueue.main.async {
                if success {
                    self.performSegue(withIdentifier: "toHomeScreen", sender: self)
                } else {
                    self.performSegue(withIdentifier: "toLoginScreen", sender: self)
                }
            }
        }
    }

}
