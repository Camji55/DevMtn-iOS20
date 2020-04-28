//
//  AddEntryViewController.swift
//  Journal
//
//  Created by Cameron Ingham on 7/4/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class AddEntryViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entryTitle = ""
    var entryTag = ""
    var entryBody = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyTextView.delegate = self
        bodyTextView.text = "Your journal entry goes here..."
        bodyTextView.textColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if bodyTextView.textColor == UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0) {
            bodyTextView.text = ""
            bodyTextView.textColor = UIColor.darkText
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            bodyTextView.text = "Your journal entry goes here..."
            bodyTextView.textColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
        }
    }
    
    @IBAction func cancelEntry(_ sender: Any) {
        let alert = UIAlertController(title: "Cancel Entry", message: "Are you sure you want to cancel this entry?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (alert: UIAlertAction!) -> Void in
            self.dismiss(animated: true, completion: nil)
        }
        let NoAction = UIAlertAction(title: "No", style: .default)
        
        alert.addAction(yesAction)
        alert.addAction(NoAction)
        
        present(alert, animated: true, completion:nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let title = titleTextField.text?.trimmingCharacters(in: .whitespaces), !title.isEmpty, let body = bodyTextView.text?.trimmingCharacters(in: .whitespaces), !body.isEmpty else{
            let alert = UIAlertController(title: "Uh oh", message: "Are you need give this entry a title and a body", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default)
            alert.addAction(action)
            present(alert, animated: true, completion:nil)
            return false
        }
        if let tag = tagTextField.text{
            entryTag = tag
        }
        entryTitle = title
        entryBody = body
        return true
    }

}
