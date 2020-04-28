//
//  Entry.swift
//  Journal
//
//  Created by Cameron Ingham on 7/4/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

class Entry: Equatable, Codable {
    
    let title: String
    let timeStamp: Date
    let bodyText: String
    let tag: String
    
    init(title: String, timeStamp: Date, bodyText: String, tag: String){
        self.title = title
        self.timeStamp = timeStamp
        self.bodyText = bodyText
        self.tag = tag
    }
    
    static func ==(lhs: Entry, rhs: Entry) -> Bool{
        return (lhs.title == rhs.title && lhs.timeStamp == rhs.timeStamp && lhs.bodyText == rhs.bodyText)
    }
    
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a 'on' MMMM dd, yyyy"
        return dateFormatter.string(from: self.timeStamp)
    }
    
    static func getDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a 'on' MMMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func getDate(fromString string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a 'on' MMMM dd, yyyy"
        guard let date = dateFormatter.date(from: string) else{
            return Date()
        }
        return date
    }
}
