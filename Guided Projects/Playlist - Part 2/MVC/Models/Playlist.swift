//
//  Playlist.swift
//  MVC
//
//  Created by Cameron Ingham on 7/4/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

class Playlist: Equatable, Codable {
    let name: String
    var songs: [Song]
    
    init(){
        self.name = "No name"
        self.songs = []
    }
    
    init(name: String){
        self.name = name
        self.songs = []
    }
    
    static func ==(lhs: Playlist, rhs: Playlist) -> Bool{
        return (lhs.name == rhs.name && lhs.songs == rhs.songs)
    }
}
