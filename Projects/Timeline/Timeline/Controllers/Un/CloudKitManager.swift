//
//  CloudKitManager.swift
//  Timeline
//
//  Created by Cameron Ingham on 8/9/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitManager {
    
    // MARK: - Functions
    static func cloudKitAvailability(completion: @escaping (Bool) -> Void) {
        CKContainer.default().accountStatus() {
            (accountStatus:CKAccountStatus, error:Error?) -> Void in
            
            if accountStatus == .available {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
