//
//  EntryController.swift
//  Journal
//
//  Created by Cameron Ingham on 7/4/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    static let shared = EntryController()
    
    var entries: [Entry] = []
    let privateDB = CKContainer.default().privateCloudDatabase
    
    func new(title: String, bodyText: String, completion: @escaping (Bool) -> Void) {
        let entry = Entry(title: title, bodyText: bodyText)
        let entryRecord = CKRecord(entry: entry)
        privateDB.save(entryRecord) { (record, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                guard let record = record,
                    let entry = Entry(record: record) else {
                    completion(false)
                    return
                }
                self.entries.append(entry)
                completion(true)
            }
        }
    }
    
    func delete(entry: Entry, completion: @escaping (Bool) -> Void) {
        let entryRecord = CKRecord(entry: entry)
        privateDB.delete(withRecordID: entryRecord.recordID) { (recordId, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                guard let entryIndex = self.entries.index(of: entry) else {
                    completion(false)
                    return
                }
                self.entries.remove(at: entryIndex)
                completion(true)
            }
        }
    }
    
    func loadAll(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Entry.EntryKeys.recordType.rawValue, predicate: predicate)
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                guard let records = records else {
                    completion(false)
                    return
                }
                let entries = records.compactMap {Entry(record: $0)}
                self.entries = entries
                completion(true)
            }
        }
    }
}
