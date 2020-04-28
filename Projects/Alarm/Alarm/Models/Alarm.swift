//
//  Alarm.swift
//  Alarm
//
//  Created by Cameron Ingham on 7/9/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

private func generateUUID() -> String {
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    var randomString = ""
    for _ in 0 ..< len {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    return randomString
}

class Alarm: Equatable, Codable {
    let uuid: String
    var name: String
    var date: Date
    var toggle: Bool
    
    init(name: String, date: Date){
        self.uuid = generateUUID()
        self.name = name
        self.date = date
        self.toggle = true
    }
    
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return (lhs.name == rhs.name && lhs.date == rhs.date && lhs.toggle == rhs.toggle)
    }
}
