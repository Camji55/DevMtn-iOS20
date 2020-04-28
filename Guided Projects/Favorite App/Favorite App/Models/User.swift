//
//  User.swift
//  Favorite App
//
//  Created by Cameron Ingham on 7/18/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

struct User: Codable {
    let favoriteApp: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case favoriteApp = "favApp"
    }
}
