//
//  Comment.swift
//  Timeline
//
//  Created by Cameron Ingham on 8/7/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CloudKit

class Comment {
    
    // MARK: - Enums
    enum CommentKeys: String {
        case textKey = "text"
        case postKey = "post"
        case typeKey = "Comment"
    }
    
    // MARK: - Properties
    let text: String
    var post: Post?
    let timeStamp: Date
    var recordID: CKRecordID?
    var recordType: String { return CommentKeys.typeKey.rawValue }
    
    // MARK: - Initializers
    init(text: String, post: Post?, timeStamp: Date = Date()) {
        self.text = text
        self.post = post
        self.timeStamp = timeStamp
    }
    
    convenience init?(record: CKRecord) {
        guard let text = record[CommentKeys.textKey.rawValue] as? String, let _ = record[CommentKeys.postKey.rawValue] as? CKReference, let timeStamp = record.creationDate else {return nil}
        self.init(text: text, post: nil, timeStamp: timeStamp)
        recordID = record.recordID
    }
    
}

// MARK: - Extensions
extension CKRecord {
    convenience init(comment: Comment) {
        guard let post = comment.post, let postRecordID = post.recordID else {fatalError()}
        let recordID = comment.recordID ?? CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: Comment.CommentKeys.typeKey.rawValue, recordID: recordID)
        self.setValue(comment.text, forKey: Comment.CommentKeys.textKey.rawValue)
        self.setValue(CKReference(recordID: postRecordID, action: .deleteSelf), forKey: Comment.CommentKeys.postKey.rawValue)
    }
}
