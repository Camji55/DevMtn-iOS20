//
//  EntryController.swift
//  CKUsers
//
//  Created by Cameron Ingham on 8/9/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    // MARK: - Outlets
    static let shared = EntryController()
    var entries = [Entry]()
    var publicDB = CKContainer.default().publicCloudDatabase
    
    // MARK: - CRUD Functions
    func createEntry(with title: String, body: String, completion: @escaping (Bool) -> Void) {
        
        guard let user = UserController.shared.user, let userRecordID = user.recordID else {
            completion(false)
            return
        }
        
        let creator = CKReference(recordID: userRecordID, action: .deleteSelf)
        let entry = Entry(title: title, body: body, creator: creator)
        let entryRecord = CKRecord(entry: entry)
        
        publicDB.save(entryRecord) { (record, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            } else {
                self.entries.append(entry)
                completion(true)
            }
        }
        
    }
    
    func fetchEntries(completion: @escaping (Bool) -> Void) {
    
        guard let user = UserController.shared.user, let userRecordID = user.recordID else {
            completion(false)
            return
        }
        
        let predicate = NSPredicate(format: "creator == %@", userRecordID)
        let query = CKQuery(recordType: Entry.EntryKeys.typeKey.rawValue, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            } else {
                guard let records = records else {
                    completion(false)
                    return
                }
                
                let entries = records.compactMap({Entry(record: $0)}).sorted(by: {$0.timeStamp < $1.timeStamp})
                self.entries = entries
                completion(true)
            }
        }
    }
    
    func deleteEntry(entry: Entry, completion: @escaping (Bool) -> Void) {
        guard let recordID = entry.recordID else {
            completion(false)
            return
        }
        publicDB.delete(withRecordID: recordID) { (record, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            } else {
                if let entryIndex = self.entries.index(of: entry) {
                    self.entries.remove(at: entryIndex)
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
}
