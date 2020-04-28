//
//  User.swift
//  CKUsers
//
//  Created by Cameron Ingham on 8/8/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CloudKit

class User {
    
    // MARK: - Enums
    enum UserKeys: String {
        case usernameKey = "username"
        case firstNameKey = "firstName"
        case lastNameKey = "lastName"
        case appleUserKey = "appleUser"
        case typeKey = "User"
    }
    
    // MARK: - Properties
    let username: String
    let firstName: String
    let lastName: String
    let appleUser: CKReference
    var recordID: CKRecordID?
    
    // MARK: - Initializers
    init(username: String, firstName: String, lastName: String, appleUser: CKReference) {
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.appleUser = appleUser
        self.recordID = CKRecordID(recordName: UUID().uuidString)
    }
    
    init?(record: CKRecord) {
        guard let username = record[UserKeys.usernameKey.rawValue] as? String, let firstName = record[UserKeys.firstNameKey.rawValue] as? String, let lastName = record[UserKeys.lastNameKey.rawValue] as? String, let appleUser = record[UserKeys.appleUserKey.rawValue] as? CKReference else {return nil}
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.appleUser = appleUser
        self.recordID = record.recordID
    }
    
}

// MARK: - Extensions
extension CKRecord {
    convenience init(user: User) {
        if(user.recordID == nil) {
            self.init(recordType: User.UserKeys.typeKey.rawValue)
        } else {
            self.init(recordType: User.UserKeys.typeKey.rawValue, recordID: user.recordID!)
        }
        
        self.setValue(user.username, forKey: User.UserKeys.usernameKey.rawValue)
        self.setValue(user.firstName, forKey: User.UserKeys.firstNameKey.rawValue)
        self.setValue(user.lastName, forKey: User.UserKeys.lastNameKey.rawValue)
        self.setValue(user.appleUser, forKey: User.UserKeys.appleUserKey.rawValue)
        
        user.recordID = self.recordID
    }
}
