//
//  iTunesItem.swift
//  iTunes Search
//
//  Created by Cameron Ingham on 7/19/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let results: [iTunesItem]
}

struct iTunesItem: Decodable {
    let song: String?
    let artist: String?
    let album: String?
    let albumCover: String
    
    enum CodingKeys: String, CodingKey {
        case song = "trackName"
        case artist = "artistName"
        case album = "collectionName"
        case albumCover = "artworkUrl100"
    }
    
}
