//
//  Post.swift
//  Timeline
//
//  Created by Cameron Ingham on 8/7/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit
import CloudKit

class Post: Equatable {
    
    // MARK: - Enums
    enum PostKeys: String {
        case photoDataKey = "photoData"
        case captionKey = "caption"
        case commentsKey = "comments"
        case typeKey = "Post"
    }
    
    // MARK: - Properties
    let photoData: Data?
    let caption: String
    let timeStamp: Date
    var recordID: CKRecordID?
    
    var recordType: String { return PostKeys.typeKey.rawValue }
    
    var comments: [Comment]

    var photo: UIImage? {
        guard let photoData = self.photoData else {return nil}
        return UIImage(data: photoData)
    }
    
    var tempPhotoURL: URL {
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString+".dat")
        try? photoData?.write(to: url)
        return url
    }
    
    // MARK: - Initializers
    init(photoData: Data?, caption: String, comments: [Comment] = [], timeStamp: Date = Date()) {
        self.photoData = photoData
        self.caption = caption
        self.comments = comments
        self.timeStamp = timeStamp
    }
    
    convenience init?(record: CKRecord) {
        guard let photoAsset = record[PostKeys.photoDataKey.rawValue] as? CKAsset, let caption = record[PostKeys.captionKey.rawValue] as? String, let timeStamp = record.creationDate else {return nil}
        let myPhotoData = try? Data(contentsOf: photoAsset.fileURL)
        self.init(photoData: myPhotoData, caption: caption, timeStamp: timeStamp)
        recordID = record.recordID
    }
    
    // MARK: - Functions
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.recordID == rhs.recordID
    }
    
}

// MARK: - Extensions
extension CKRecord {
    convenience init(post: Post) {
        let recordID = post.recordID ?? CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: Post.PostKeys.typeKey.rawValue, recordID: recordID)
        self.setValue(CKAsset(fileURL: post.tempPhotoURL), forKey: Post.PostKeys.photoDataKey.rawValue)
        self.setValue(post.caption, forKey: Post.PostKeys.captionKey.rawValue)
        
        post.recordID = recordID
    }
}


