//
//  Pokemon.swift
//  Pokedex
//
//  Created by Cameron Ingham on 7/17/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

struct Pokemon {
    
    private let nameKey = "name"
    private let weightKey = "weight"
    private let idKey = "id"
    private let spritesKey = "sprites"
    private let imageKey = "front_default"
    
    let name: String
    let weight: Int
    let id: Int
    let imageURL: String
    
    init?(pokeDicktionary: [String: Any]){
        guard let name = pokeDicktionary[nameKey] as? String, let weight = pokeDicktionary[weightKey] as? Int, let id = pokeDicktionary[idKey] as? Int, let spritesDictionary = pokeDicktionary[spritesKey] as? [String: Any], let image = spritesDictionary[imageKey] as? String else {return nil}
        self.name = name
        self.weight = weight
        self.id = id
        self.imageURL = image
    }
    
}
