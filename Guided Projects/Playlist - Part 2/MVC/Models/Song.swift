//
//  Song.swift
//  MVC
//
//  Created by Cameron Ingham on 7/4/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

class Song: Equatable, Codable {
    let name: String
    var artist: String
    
    init(){
        self.name = "No name"
        self.artist = "No artists"
    }
    
    init(name: String, artist: String){
        self.name = name
        self.artist = artist
    }
    
    static func ==(lhs: Song, rhs: Song) -> Bool{
        return (lhs.name == rhs.name && lhs.artist == rhs.artist)
    }
}
