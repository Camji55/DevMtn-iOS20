//
//  MainViewController.swift
//  Views and Storyboards
//
//  Created by Cameron Ingham on 7/2/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("View did load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameLabel.backgroundColor = UIColor.darkGray
        nameLabel.textColor = UIColor.white
        
        print("View will appear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("View did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("View will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("View did disappear")
    }
    
}

