//
//  Message.swift
//  Bulletin Board
//
//  Created by Cameron Ingham on 8/6/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CloudKit

struct Message {
    
    enum MessageKeys: String {
        case messageText = "messageText"
        case timeStamp = "timeStamp"
        case recordType = "Message"
    }
    
    let messageText: String
    let timeStamp: Date
    
    init(messageText: String) {
        self.messageText = messageText
        self.timeStamp = Date()
    }
    
    init?(record: CKRecord) {
        guard let messageText = record[MessageKeys.messageText.rawValue] as? String, let timeStamp = record[MessageKeys.timeStamp.rawValue] as? Date else {return nil}
        self.messageText = messageText
        self.timeStamp = timeStamp
    }
    
}

extension CKRecord {
    convenience init(message: Message) {
        self.init(recordType: Message.MessageKeys.recordType.rawValue)
        self.setValue(message.messageText, forKey: Message.MessageKeys.messageText.rawValue)
        self.setValue(message.timeStamp, forKey: Message.MessageKeys.timeStamp.rawValue)
    }
}
