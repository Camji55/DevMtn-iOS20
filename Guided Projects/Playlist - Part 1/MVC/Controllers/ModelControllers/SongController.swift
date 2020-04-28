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
        let newSong = Song(name: name, artist: artist)
        playlist.songs.append(newSong)
    }
    
    static func deleteSong(song: Song, playlist: Playlist){
        guard let songIndex = playlist.songs.index(of: song) else{
            return
        }
        playlist.songs.remove(at: songIndex)
    }
}
