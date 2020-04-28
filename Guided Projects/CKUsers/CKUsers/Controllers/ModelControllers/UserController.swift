//
//  UserController.swift
//  CKUsers
//
//  Created by Cameron Ingham on 8/8/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CloudKit

class UserController {
    
    // MARK: - Properties
    static let shared = UserController()
    let publicDB = CKContainer.default().publicCloudDatabase
    var user: User?
    
    // MARK: - CRUD Functions
    func create(username: String, firstName: String, lastName: String, completion: @escaping (Bool, String?) -> Void) {
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            if let error = error {
                completion(false, error.localizedDescription)
                return
            }
            
            guard let recordID = recordID else {
                completion(false, "Unknown Error")
                return
            }
            
            let appleUser = CKReference(recordID: recordID, action: .deleteSelf)
            let user = User(username: username, firstName: firstName, lastName: lastName, appleUser: appleUser)
            let userRecord = CKRecord(user: user)
            
            self.fetch(completion: { (success, error) in
                if success {
                    completion(false, "Account already exists for this user. Try logging in.")
                    return
                } else {
                    self.publicDB.save(userRecord, completionHandler: { (_, error) in
                        if let error = error {
                            completion(false, error.localizedDescription)
                            return
                        }
                        
                        self.user = user
                        completion(true, nil)
                    })
                }
            })
        }
    }
    
    func fetch(completion: @escaping (Bool, String?) -> Void) {
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            if let error = error {
                completion(false, error.localizedDescription)
                return
            }
            
            guard let recordID = recordID else {
                completion(false, "Unknown Error")
                return
            }
            
            let appleUser = CKReference(recordID: recordID, action: .deleteSelf)
            let predicate = NSPredicate(format: "appleUser == %@", appleUser)
            let query = CKQuery(recordType: User.UserKeys.typeKey.rawValue, predicate: predicate)
            
            self.publicDB.perform(query, inZoneWith: nil, completionHandler: { (records, error) in
                if let error = error {
                    completion(false, error.localizedDescription)
                    return
                }
                
                let record = records?.compactMap {$0}.first
                
                guard let unwrappedRecord = record else {
                    completion(false, "Unknown Error")
                    return
                }
                
                let user = User(record: unwrappedRecord)
                UserController.shared.user = user
                completion(true, nil)
            })
        }
    }
    
}
