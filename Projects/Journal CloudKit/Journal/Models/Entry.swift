//
//  Entry.swift
//  Journal
//
//  Created by Cameron Ingham on 7/4/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CloudKit

class Entry: Equatable {
    
    enum EntryKeys: String {
        case title = "title"
        case timeStamp = "timeStamp"
        case bodyTest = "bodyText"
        case recordType = "Entry"
    }
    
    let title: String
    let timeStamp: Date
    let bodyText: String
    var recordID: CKRecordID?
    
    init(title: String, bodyText: String) {
        self.title = title
        self.timeStamp = Date()
        self.bodyText = bodyText
        self.recordID = CKRecordID(recordName: UUID().uuidString)
    }
    
    init?(record: CKRecord) {
        guard let title = record[EntryKeys.title.rawValue] as? String, let timeStamp = record[EntryKeys.timeStamp.rawValue] as? Date, let bodyText = record[EntryKeys.bodyTest.rawValue] as? String else {return nil}
        self.title = title
        self.timeStamp = timeStamp
        self.bodyText = bodyText
        self.recordID = record.recordID
    }
    
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a 'on' MMMM dd, yyyy"
        return dateFormatter.string(from: self.timeStamp)
    }
    
    static func ==(lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.timeStamp == rhs.timeStamp && lhs.bodyText == rhs.bodyText
    }
    
}

extension CKRecord {
    convenience init(entry: Entry) {
        if(entry.recordID == nil){
            self.init(recordType: Entry.EntryKeys.recordType.rawValue)
        } else {
            self.init(recordType: Entry.EntryKeys.recordType.rawValue, recordID: entry.recordID!)
        }
        
        self.setValue(entry.title, forKey: Entry.EntryKeys.title.rawValue)
        self.setValue(entry.timeStamp, forKey: Entry.EntryKeys.timeStamp.rawValue)
        self.setValue(entry.bodyText, forKey: Entry.EntryKeys.bodyTest.rawValue)
        
        entry.recordID = self.recordID
        
    }
}
