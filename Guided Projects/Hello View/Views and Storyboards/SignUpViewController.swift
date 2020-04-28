//
//  SignUpViewController.swift
//  Views and Storyboards
//
//  Created by Cameron Ingham on 7/2/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToWelcomeVC" {
            guard let destinationVC = segue.destination as? WelcomeViewController else {
                print("This is where the bad stuff happens")
                return
            }
            destinationVC.name = nameTextField.text!
            print("This worked!")
        }
        else {
            print("This is where the bad stuff happens in an if")
        }
    }
    
}
