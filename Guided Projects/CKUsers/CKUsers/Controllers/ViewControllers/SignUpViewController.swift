//
//  LoginViewController.swift
//  CKUsers
//
//  Created by Cameron Ingham on 8/8/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        createToolbar()
        usernameTextField.becomeFirstResponder()
    }
    
    // MARK: - TextField Delegate Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            firstNameTextField.becomeFirstResponder()
        } else if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        } else {
            lastNameTextField.resignFirstResponder()
        }
        return true
    }
    
    // MARK: - Interactions
    @IBAction func signUp(_ sender: UIButton) {
        guard let username = usernameTextField.text?.trimmingCharacters(in: .whitespaces), !username.isEmpty, let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespaces), !firstName.isEmpty, let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespaces), !lastName.isEmpty else {
            self.present(AlertManager.errorAlert(message: "All fields are required"), animated: true, completion: nil)
            return
        }
        
        UserController.shared.create(username: username, firstName: firstName, lastName: lastName) { (success, error) in
            DispatchQueue.main.async {
                if let error = error{
                    self.present(AlertManager.errorAlert(message: error), animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: "toHomeScreen", sender: self)
                }
            }
        }
    }
    
    // MARK: - Functions
    func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        doneButton.tintColor = UIColor.darkGray
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        usernameTextField.inputAccessoryView = toolbar
        firstNameTextField.inputAccessoryView = toolbar
        lastNameTextField.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard(){
        usernameTextField.resignFirstResponder()
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
    }

}
