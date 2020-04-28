//
//  PostsTableViewController.swift
//  Timeline
//
//  Created by Cameron Ingham on 8/7/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class PostsTableViewController: UITableViewController, UISearchBarDelegate {

    // MARK: - Properties
    var filteredPosts: [Post] = []
    var isFiltering = false
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        createToolbar()
        styleNav()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
        self.refreshControl = refreshControl
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshPosts), name: PostController.PostsChangedNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    // MARK: - TableView Delegate & Data Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPosts.count
        } else {
            return PostController.shared.posts.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {return UITableViewCell()}
        let post: Post
        
        if isFiltering {
            post = filteredPosts[indexPath.row]
        } else {
            post = PostController.shared.posts[indexPath.row]
        }
        
        cell.post = post
    
        return cell
    }
    
    // MARK: - SearchBar Delegate Functions
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.trimmingCharacters(in: .whitespaces).lowercased() else {return}
        if searchTerm.isEmpty {
            filteredPosts = []
            isFiltering = false
            tableView.reloadData()
            searchBar.resignFirstResponder()
        } else {
            filteredPosts = PostController.shared.postsMatchingSearch(term: searchTerm)
            isFiltering = true
            tableView.reloadData()
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        filteredPosts = []
        isFiltering = false
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Functions
    func loadPosts(completion: @escaping (Bool) -> Void) {
        PostController.shared.loadPosts { (success, error) in
            DispatchQueue.main.async {
                if let error = error {
                    AlertManager.errorAlert(presentingViewController: self, message: error)
                    completion(false)
                } else {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                    completion(true)
                   
                }
            }
        }
    }
    
    func styleNav() {
        if let font = UIFont(name: "Mattilda", size: 30) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: UIColor.darkGray]
        }
        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        doneButton.tintColor = UIColor.darkGray
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        searchBar.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard(){
        searchBar.resignFirstResponder()
    }
    
    @objc func refreshPosts() {
        loadPosts { (_) in }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? PostViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
        if isFiltering {
            destination.post = filteredPosts[indexPath.row]
        } else {
            destination.post = PostController.shared.posts[indexPath.row]
        }
    }

}
