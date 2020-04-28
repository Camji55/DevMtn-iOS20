//
//  Entry.swift
//  CKUsers
//
//  Created by Cameron Ingham on 8/9/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CloudKit

class Entry: Equatable {
    
    // MARK: - Enums
    enum EntryKeys: String {
        case titleKey = "Title"
        case bodyKey = "body"
        case timeStampKey = "timeStamp"
        case creatorkey = "creator"
        case typeKey = "Entry"
    }
    
    // MARK: - Properties
    var title: String
    var body: String
    var timeStamp: Date
    let creator: CKReference
    var recordID: CKRecordID?
    
    // MARK: - Initializers
    init(title: String, body: String, creator: CKReference) {
        self.title = title
        self.body = body
        self.timeStamp = Date()
        self.creator = creator
    }
    
    init?(record: CKRecord) {
        guard let title = record[EntryKeys.titleKey.rawValue] as? String, let body = record[EntryKeys.bodyKey.rawValue] as? String, let timeStamp = record.creationDate, let creator = record[EntryKeys.creatorkey.rawValue] as? CKReference else {return nil}
        
        self.title = title
        self.body = body
        self.timeStamp = timeStamp
        self.creator = creator
        self.recordID = record.recordID
    }
    
    // MARK: - Equatable Protocol
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.recordID == rhs.recordID
    }
    
}

// MARK: - Extensions
extension CKRecord {
    convenience init(entry: Entry) {
        let recordID = entry.recordID ?? CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: Entry.EntryKeys.typeKey.rawValue, recordID: recordID)
        
        self.setValue(entry.title, forKey: Entry.EntryKeys.titleKey.rawValue)
        self.setValue(entry.body, forKey: Entry.EntryKeys.bodyKey.rawValue)
        self.setValue(entry.timeStamp, forKey: Entry.EntryKeys.timeStampKey.rawValue)
        self.setValue(entry.creator, forKey: Entry.EntryKeys.creatorkey.rawValue)
        
        entry.recordID = recordID
    }
}
