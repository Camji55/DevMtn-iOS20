//
//  SongController.swift
//  MVC
//
//  Created by Cameron Ingham on 7/4/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

class SongController {
    static func createSong(name: String, artist: String, playlist: Playlist){
        let _ = Song(name: name, artist: artist, playlist: playlist)
        CoreDataManager.saveToPersistantStore()
    }
    
    static func deleteSong(_ song: Song){
        CoreDataManager.delete(object: song)
        CoreDataManager.saveToPersistantStore()
    }
    
}
