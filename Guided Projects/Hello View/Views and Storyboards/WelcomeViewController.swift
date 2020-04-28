//
//  WelcomeViewController.swift
//  Views and Storyboards
//
//  Created by Cameron Ingham on 7/2/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var name: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        welcomeLabel.text = "Welcome, \(name)!"
    }
    
}
