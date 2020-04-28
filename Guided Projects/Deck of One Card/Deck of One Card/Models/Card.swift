//
//  Card.swift
//  Deck of One Card
//
//  Created by Cameron Ingham on 7/16/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

struct Deck: Codable {
    let cards: [Card]
}

struct Card: Codable {
    let image: String
    let value: String
    let suit: String
}
