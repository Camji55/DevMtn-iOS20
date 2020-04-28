//
//  PostViewController.swift
//  Timeline
//
//  Created by Cameron Ingham on 8/7/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // MARK: - Properties
    var post: Post?
    var localComments: [String]? {
        var comments = post?.comments.compactMap({$0.text})
        if post?.caption != "" {
            comments?.insert(post!.caption, at: 0)
        }
        return comments
    }
    
    // MARK: - Outlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var commentsTable: UITableView!
    @IBOutlet weak var addCommentView: UIView!
    @IBOutlet weak var commentBar: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsTable.delegate = self
        commentsTable.dataSource = self
        commentBar.delegate = self
        updateView()
        loadComments()

        NotificationCenter.default.addObserver(self, selector: #selector(refreshComments), name: PostController.PostCommentsChangedNotification, object: nil)
    }
    
    // MARK: - TableView Delegate & Data Source Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localComments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell"), let localComments = localComments else {return UITableViewCell()}
        cell.textLabel?.text = localComments[indexPath.row]
        
        return cell
    }
    
    // MARK: - TextField Delegate Functions
    func textFieldDidBeginEditing(_ textField: UITextField) {
        postButton.isEnabled = true
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 250, width:self.view.frame.size.width, height:self.view.frame.size.height);
            
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        postButton.isEnabled = false
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 250, width:self.view.frame.size.width, height:self.view.frame.size.height);
            
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        commentBar.resignFirstResponder()
        return true
    }
    
    // MARK: - Interactions
    
    @IBAction func showActions(_ sender: Any) {
        guard let post = self.post else {return}
        PostController.shared.isSubscribedToPost(post: post) { (isSubscribed) in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                let shareAction = UIAlertAction(title: "Share", style: .default) { (_) in
                    var shareView = UIActivityViewController(activityItems: [], applicationActivities: [])
                    if let image = post.photo {
                        shareView = UIActivityViewController(activityItems: [image], applicationActivities: [])
                    }
                    self.present(shareView, animated: true, completion: nil)
                }
                let followingAction = UIAlertAction(title: isSubscribed ? "Unfollow" : "Follow", style: .default, handler: { (action) in
                    PostController.shared.toggleSubscriptionTo(post: post, completion: { (_, _) in })
                })
                let reportAction = UIAlertAction(title: "Report", style: .destructive) { (_) in
                    // FIXME: - Report Post
                }
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                    let confirmAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
                        PostController.shared.deletePost(post: post, completion: { (success, error) in
                            DispatchQueue.main.async {
                                if let error = error {
                                    AlertManager.errorAlert(presentingViewController: self, message: error)
                                } else {
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                            
                        })
                    })
                    AlertManager.confirmAlert(presentingViewController: self, confirmAction: confirmAction)
                }
                
                alert.addAction(shareAction)
                alert.addAction(followingAction)
                alert.addAction(reportAction)
                alert.addAction(deleteAction)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func addComment(_ sender: Any) {
        guard let post = self.post, let commentText = commentBar.text?.trimmingCharacters(in: .whitespaces), !commentText.isEmpty else {return}
        PostController.shared.addComment(toPost: post, commentText: commentText, completion: { (success, error) in
            DispatchQueue.main.async {
                if let error = error {
                    AlertManager.errorAlert(presentingViewController: self, message: error)
                } else {
                    self.commentsTable.reloadData()
                    self.commentBar.text = ""
                    self.commentBar.resignFirstResponder()
                }
            }
        })
    }
    
    // MARK: - Functions
    func updateView() {
        guard let post = post else {return}
        self.postImage.image = post.photo
        postImage.layer.cornerRadius = 5
        postImage.layer.masksToBounds = true
        bgView.layer.cornerRadius = 5
        bgView.layer.shadowColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1).cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 4)
        bgView.layer.shadowOpacity = 0.75
        bgView.layer.shadowRadius = 4.0
        headerView.layer.masksToBounds = true
        commentBar.borderStyle = .none
        commentBar.layer.cornerRadius = 10
        commentBar.layer.masksToBounds = true
        let insets = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: self.commentBar.frame.height))
        commentBar.leftView = insets
        commentBar.leftViewMode = .always
        styleNav()
    }
    
    func styleNav() {
        if let font = UIFont(name: "Mattilda", size: 30) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: UIColor.darkGray]
        }

        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func loadComments() {
        guard let post = post else {return}
        PostController.shared.loadCommentsFor(post: post) { (success, error) in
            DispatchQueue.main.async {
                if let error = error {
                    AlertManager.errorAlert(presentingViewController: self, message: error)
                } else {
                    self.commentsTable.reloadData()
                    self.commentsTable.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    @objc func refreshComments() {
        loadComments()
    }
    
}
