//
//  Joke.swift
//  Chuck Norris Jokes
//
//  Created by Cameron Ingham on 7/18/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

struct Joke: Codable {
    let joke: String
    let image: String
    
    enum CodingKeys: String, CodingKey{
        case joke = "value"
        case image = "icon_url"
    }
}
