//
//  PlaylistController.swift
//  MVC
//
//  Created by Cameron Ingham on 7/4/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

class PlaylistController {
    
    static let shared = PlaylistController()
    
    var playlists: [Playlist] = []
    
    static func createPlaylist(name: String){
        let newPlaylist = Playlist(name: name)
        PlaylistController.shared.playlists.append(newPlaylist)
    }

    static func deletePlaylist(playlist: Playlist){
        guard let playlistIndex = PlaylistController.shared.playlists.index(of: playlist) else {
            return
        }
        PlaylistController.shared.playlists.remove(at: playlistIndex)
    }
    
    
}
