//
//  Friend.swift
//  FriendRater
//
//  Created by Cameron Ingham on 7/7/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

class Friend: Equatable, Codable {
    var name: String
    var rating: Int
    
    init(name: String, rating: Int){
        self.name = name
        self.rating = rating
    }
    
    static func ==(lhs: Friend, rhs: Friend) -> Bool {
        return (lhs.name == rhs.name && lhs.rating == rhs.rating)
    }
}
