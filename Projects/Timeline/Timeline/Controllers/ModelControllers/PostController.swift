//
//  PostController.swift
//  Timeline
//
//  Created by Cameron Ingham on 8/7/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit
import CloudKit

class PostController {
    
    init(){
        self.subscribeToNewPosts { (_) in }
    }
    
    // MARK: - Properties
    static let shared = PostController()
    static let PostsChangedNotification = Notification.Name("PostsChangedNotification")
    static let PostCommentsChangedNotification = Notification.Name("PostCommentsChangedNotification")
    let publicDB = CKContainer.default().publicCloudDatabase
    var posts = [Post]()

    // MARK: - CRUD Functions
    func newPost(with image: UIImage, caption: String, completion: @escaping (Bool, String?) -> Void){
        let photo = UIImageJPEGRepresentation(image, 1)
        let post = Post(photoData: photo, caption: caption)
        let postRecord = CKRecord(post: post)
        ActivityIndicatorManager.setNetworkActivityIndicator(visible: true)
        publicDB.save(postRecord) { (record, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    ActivityIndicatorManager.setNetworkActivityIndicator(visible: false)
                    completion(false, "Error saving post.")
                } else {
                    self.posts.insert(post, at: 0)
                    ActivityIndicatorManager.setNetworkActivityIndicator(visible: false)
                    completion(true, nil)
                }
            }
        }
        
        self.subscribeToPost(post: post, message: "Someone commented on your post!", completion: { (_,_) in })
    }
    
    func addComment(toPost post: Post, commentText: String, completion: @escaping (Bool,String?) -> Void) {
        let comment = Comment(text: commentText, post: post)
        let commentRecord = CKRecord(comment: comment)
        ActivityIndicatorManager.setNetworkActivityIndicator(visible: true)
        publicDB.save(commentRecord) { (record, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    ActivityIndicatorManager.setNetworkActivityIndicator(visible: false)
                    completion(false, "Error commenting on post.")
                } else {
                    post.comments.append(comment)
                    ActivityIndicatorManager.setNetworkActivityIndicator(visible: false)
                    completion(true, nil)
                }
            }
        }
        
    }
    
    func loadPosts(completion: @escaping (Bool, String?) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Post.PostKeys.typeKey.rawValue, predicate: predicate)
        ActivityIndicatorManager.setNetworkActivityIndicator(visible: true)
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    ActivityIndicatorManager.setNetworkActivityIndicator(visible: false)
                    completion(false, "Error loading posts")
                } else {
                    let posts = records?.compactMap {Post(record: $0)}
                    self.posts = posts?.sorted(by: {$0.timeStamp > $1.timeStamp}) ?? []
                    ActivityIndicatorManager.setNetworkActivityIndicator(visible: false)
                    let _ = posts?.compactMap({self.loadCommentsFor(post: $0, completion: { (success, error) in
                        completion(success, error)
                    })})
                    completion(true, nil)
                }
            }
        }
    }
    
    func loadCommentsFor(post: Post, completion: @escaping (Bool, String?) -> Void) {
        let postReference = CKReference(record: CKRecord(post: post), action: .deleteSelf)
        let predicate = NSPredicate(format: "post == %@", postReference)
        let query = CKQuery(recordType: Comment.CommentKeys.typeKey.rawValue, predicate: predicate)
        ActivityIndicatorManager.setNetworkActivityIndicator(visible: true)
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    ActivityIndicatorManager.setNetworkActivityIndicator(visible: false)
                    completion(false, "Error loading comments for this post")
                } else {
                    let comments = records?.compactMap {Comment(record: $0)}
                    post.comments = comments?.sorted(by: {$0.timeStamp < $1.timeStamp}) ?? []
                    ActivityIndicatorManager.setNetworkActivityIndicator(visible: false)
                    completion(true, nil)
                }
            }
        }
    }
    
    func deletePost(post: Post, completion: @escaping (Bool, String?) -> Void) {
        guard let postRecord = post.recordID else {
            completion(false, "Error deleting Post.")
            return
        }
        publicDB.delete(withRecordID: postRecord) { (_, error) in
            if let error = error {
                completion(false, "Error deleting Post.")
                print(error.localizedDescription)
                return
            } else {
                guard let postIndex = self.posts.index(of: post) else {
                    completion(false, "Error deleting Post.")
                    return
                }
                self.posts.remove(at: postIndex)
                completion(true, nil)
                return
            }
        }
    }
    
    // MARK: - Subscription Functions
    func subscribeToNewPosts(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let subscription = CKQuerySubscription(recordType: Post.PostKeys.typeKey.rawValue, predicate: predicate, subscriptionID: "allPosts", options: [.firesOnRecordCreation, .firesOnRecordDeletion, .firesOnRecordUpdate])
        let notificationInfo = CKNotificationInfo()
        notificationInfo.shouldSendContentAvailable = true
        subscription.notificationInfo = notificationInfo
        publicDB.save(subscription) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func subscribeToPost(post: Post, message: String, completion: @escaping (Bool, String?) -> Void) {
        guard let recordID = post.recordID else {return}
        let predicate = NSPredicate(format: "post == %@", recordID)
        let subscription = CKQuerySubscription(recordType: Comment.CommentKeys.typeKey.rawValue, predicate: predicate, subscriptionID: recordID.recordName, options: [.firesOnRecordCreation, .firesOnRecordDeletion, .firesOnRecordUpdate])
        let notificationInfo = CKNotificationInfo()
        notificationInfo.shouldSendContentAvailable = true
        notificationInfo.alertBody = message
        notificationInfo.desiredKeys = [Comment.CommentKeys.textKey.rawValue, Comment.CommentKeys.postKey.rawValue]
        subscription.notificationInfo = notificationInfo
        publicDB.save(subscription) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false, "Error subscribing to this post.")
            } else {
                completion(true, nil)
            }
        }
    }
    
    func isSubscribedToPost(post: Post, completion: @escaping (Bool) -> Void) {
        guard let subscriptionID = post.recordID?.recordName else {
            completion(false)
            return
        }
        publicDB.fetch(withSubscriptionID: subscriptionID) { (_, error) in
            if let error = error{
                print(error.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func toggleSubscriptionTo(post: Post, completion: @escaping (Bool, String?) -> Void) {
        isSubscribedToPost(post: post) { (success) in
            if success {
                self.deleteSubscriptionTo(post: post, completion: { (success, error) in
                    completion(success, error)
                })
            } else {
                self.subscribeToPost(post: post, message: "Someone commented on a post you've followed", completion: { (success, error) in
                    completion(success, error)
                })
            }
        }
    }
    
    func deleteSubscriptionTo(post: Post, completion: @escaping (Bool, String?) -> Void) {
        guard let subscriptionID = post.recordID?.recordName else {
            completion(false, "Error unsubscribing from post.")
            return
        }
        publicDB.delete(withSubscriptionID: subscriptionID) { (_, error) in
            if let error = error{
                print(error.localizedDescription)
                completion(false, "Error unsubscribing from post.")
            } else {
                completion(true, nil)
            }
        }
    }
    
    // MARK: - Functions
    func postsMatchingSearch(term: String) -> [Post] {
        let filteredPostsByCaption = posts.filter {
            $0.caption.lowercased().contains(term)
        }
        
        let filteredPostsByComment = posts.filter {
            $0.comments.contains(where: {
                $0.text.lowercased().contains(term)
            })
        }
        
        var results: [Post] = []
        let _ = filteredPostsByCaption.compactMap {results.append($0)}
        let _ = filteredPostsByComment.compactMap {
            if !results.contains($0) {
                results.append($0)
            }
        }
        
        print(results.compactMap({$0.caption}))
        
        return results
    }

}

