//
//  Journal.swift
//  Journal
//
//  Created by Cameron Ingham on 7/5/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

class Journal: Equatable, Codable {
    
    let title: String
    var entries: [Entry]
    
    init(title: String){
        self.title = title
        self.entries = []
    }
    
    static func ==(lhs: Journal, rhs: Journal) -> Bool{
        return (lhs.title == rhs.title && lhs.entries == rhs.entries)
    }
}
