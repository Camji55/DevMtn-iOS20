//
//  EntryDetailViewController.swift
//  CKUsers
//
//  Created by Cameron Ingham on 8/9/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    var entry: Entry? {
        didSet {
            loadViewIfNeeded()
            updateView()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleTextField.delegate = self
        createToolbar()
        if entry == nil {
            self.title = "Add Entry"
        } else {
            self.title = "View Entry"
        }
    }

    // MARK: - TextField Delegate Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bodyTextView.becomeFirstResponder()
        return true
    }
    
    // MARK: - Interactions
    @IBAction func saveButton(_ sender: Any) {
        let body = bodyTextView.text.trimmingCharacters(in: .whitespaces)
        guard let title = titleTextField.text?.trimmingCharacters(in: .whitespaces), !title.isEmpty, !body.isEmpty else {return}
        
        if entry == nil {
            EntryController.shared.createEntry(with: title, body: body) { (success) in
                DispatchQueue.main.async {
                    if success {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        } else {
            //Update Entry
        }
    }
    
    // MARK: - Functions
    func updateView() {
        guard let entry = entry else {return}
        self.titleTextField.text = entry.title
        self.bodyTextView.text = entry.body
    }
    
    func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonKeyboard))
        nextButton.tintColor = UIColor.darkGray
        doneButton.tintColor = UIColor.darkGray
        toolbar.setItems([nextButton, flexibleSpace, doneButton], animated: true)
        titleTextField.inputAccessoryView = toolbar
        bodyTextView.inputAccessoryView = toolbar
    }
    
    @objc func nextButtonKeyboard() {
        if titleTextField.isEditing {
            bodyTextView.becomeFirstResponder()
        } else {
            bodyTextView.resignFirstResponder()
        }
    }
    
    @objc func dismissKeyboard() {
        titleTextField.resignFirstResponder()
        bodyTextView.resignFirstResponder()
    }
    
}
