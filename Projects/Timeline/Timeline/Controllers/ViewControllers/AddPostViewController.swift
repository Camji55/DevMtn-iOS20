//
//  AddPostTableViewController.swift
//  Timeline
//
//  Created by Cameron Ingham on 8/7/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: - Properties
    let imagePicker = UIImagePickerController()
    var autoPick = true
    
    // MARK: - Outlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        captionField.delegate = self
        updateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if autoPick == true {
            self.present(imagePicker, animated: true, completion: nil)
            autoPick = false
        }
    }
    
    // MARK: - Image Picker Delegate Functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        postImage.image = image
        postImage.isHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - TextField Delegate Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        captionField.resignFirstResponder()
        return true
    }
    
    // MARK: - Interactions
    @IBAction func addImage(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func post(_ sender: Any) {
        guard let caption = captionField.text?.trimmingCharacters(in: .whitespaces) else {return}
        if self.postImage.image != UIImage(named: "AddImagePlaceholder") {
            loadingView.isHidden = false
            view.isUserInteractionEnabled = false
            PostController.shared.newPost(with: postImage.image!, caption: caption) { (success, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        AlertManager.errorAlert(presentingViewController: self, message: error)
                        print("Error posting.")
                    } else {
                        self.postImage.image = UIImage(named: "AddImagePlaceholder")!
                        self.captionField.text = ""
                        self.tabBarController?.selectedIndex = 0
                        
                    }
                    self.loadingView.isHidden = true
                    self.view.isUserInteractionEnabled = true
                }
            }
        } else {
            AlertManager.errorAlert(presentingViewController: self, message: "Must select and image.")
        }
        autoPick = true
    }
    
    // MARK: - Functions
    
    func updateView() {
        createToolbar()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        postImage.layer.cornerRadius = 5
        postImage.layer.masksToBounds = true
        bgView.layer.cornerRadius = 5
        bgView.layer.shadowColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1).cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 4)
        bgView.layer.shadowOpacity = 0.4
        bgView.layer.shadowRadius = 4.0
        headerView.layer.masksToBounds = true
        captionField.borderStyle = .none
        captionField.layer.cornerRadius = 10
        captionField.layer.masksToBounds = true
        let insets = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: self.captionField.frame.height))
        captionField.leftView = insets
        captionField.leftViewMode = .always
        postButton.layer.cornerRadius = 10
        postButton.layer.masksToBounds = true
        loadingView.layer.cornerRadius = 5
        loadingView.layer.masksToBounds = true
        styleNav()
    }
    
    func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        doneButton.tintColor = UIColor.darkGray
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        captionField.inputAccessoryView = toolbar
    }
    
    func styleNav() {
        if let font = UIFont(name: "Mattilda", size: 30) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: UIColor.darkGray]
        }
        
        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func dismissKeyboard(){
        captionField.resignFirstResponder()
    }

}
