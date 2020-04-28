//
//  FriendDetailViewController.swift
//  FriendRater
//
//  Created by Cameron Ingham on 7/7/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class FriendDetailViewController: UIViewController, UITextFieldDelegate {
    
    var friend: Friend?
    
    @IBOutlet weak var friendTextField: UITextField!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let friendName = textField.text?.trimmingCharacters(in: .whitespaces), !friendName.isEmpty else{
            self.title = "Add Friend"
            return
        }
        self.title = friendName
    }
    
    @objc func shouldPop(){
        if(friend != nil){
            guard let friendName = friendTextField.text?.trimmingCharacters(in: .whitespaces), !friendName.isEmpty else{
                return
            }
            let updatedFriend = Friend(name: friendName, rating: Int(self.ratingSlider.value))
            guard let friendIndex = FriendController.shared.friends.index(of: friend!) else{
                return
            }
            
            if(FriendController.shared.friends[friendIndex] != updatedFriend){
                let alert = UIAlertController(title: "Cancel Changes?", message: "Are you sure you want to cancel the changes you made?", preferredStyle: .alert)
                let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (alert: UIAlertAction!) -> Void in
                    self.navigationController?.popViewController(animated: true)
                }
                let NoAction = UIAlertAction(title: "No", style: .default)
                
                alert.addAction(yesAction)
                alert.addAction(NoAction)
                
                present(alert, animated: true, completion:nil)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func sliderDidChange(_ sender: UISlider) {
        ratingLabel.text = "Rating: \(Int(sender.value))"
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let friendName = friendTextField.text?.trimmingCharacters(in: .whitespaces), !friendName.isEmpty else{
            return
        }
        if(friend == nil){
            FriendController.shared.createFriend(name: friendName, rating: Int(ratingSlider.value))
            self.navigationController?.popViewController(animated: true)
        }
        else {
            FriendController.shared.updateFriend(friend: friend!, name: friendName, rating: Int(ratingSlider.value))
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupViews(){
        friendTextField.delegate = self
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(self.shouldPop))
        friendTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        if(friend != nil){
            title = friend?.name
        }
        else{
            title = "Add Friend"
        }
        updateViews()
    }
    
    func updateViews(){
        if let friendName = friend?.name, let ratingLabel = friend?.rating {
            self.friendTextField.text = friendName
            self.ratingLabel.text = "Rating: \(ratingLabel)"
            self.ratingSlider.value = Float(ratingLabel)
        }
    }

}
