//
//  MessageController.swift
//  Bulletin Board
//
//  Created by Cameron Ingham on 8/6/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CloudKit

class MessageController {
    
    // MARK: - Properties
    static let shared = MessageController()
    
    var messages: [Message] = []
    let publicDB = CKContainer.default().publicCloudDatabase
    
    // MARK: - Functions
    func post(with messageText: String, completion: @escaping (Bool) -> Void){
        let message = Message(messageText: messageText)
        let messageRecord = CKRecord(message: message)
        publicDB.save(messageRecord) { (record, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                guard let record = record, let message = Message(record: record) else {
                    completion(false)
                    return
                }
                self.messages.append(message)
                completion(true)
            }
        }
    }
    
    func loadAll(completion: @escaping (Bool) -> Void){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Message.MessageKeys.recordType.rawValue, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                guard let records = records else {
                    completion(false)
                    return
                }
                let messages = records.compactMap {Message(record: $0)}
                self.messages = messages
                completion(true)
            }
        }
    }
    
}
