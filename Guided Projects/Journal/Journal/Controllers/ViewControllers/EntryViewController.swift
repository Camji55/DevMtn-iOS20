//
//  EntryViewController.swift
//  Journal
//
//  Created by Cameron Ingham on 7/12/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet weak var goodDaySegment: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entry: Entry? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = entry == nil ? "Add Entry" : "Edit Entry"
    }
    
    @IBAction func save(_ sender: Any) {
        guard let title = titleTextField.text?.trimmingCharacters(in: .whitespaces), !title.isEmpty, let body = bodyTextView.text?.trimmingCharacters(in: .whitespaces) else {return}
        let isGoodDay = goodDaySegment.selectedSegmentIndex == 0
        if entry == nil {
            EntryController.create(title: title, body: body, isGoodDay: isGoodDay)
        } else {
            EntryController.update(entry: entry!, title: title, body: body, isGoodDay: isGoodDay)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews(){
        guard let entry = entry else {return}
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
        goodDaySegment.selectedSegmentIndex = entry.isGoodDay ? 0 : 1
    }
}
