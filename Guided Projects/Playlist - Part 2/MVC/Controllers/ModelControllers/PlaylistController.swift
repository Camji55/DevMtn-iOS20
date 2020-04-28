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
    
    func createPlaylist(name: String){
        let newPlaylist = Playlist(name: name)
        PlaylistController.shared.playlists.append(newPlaylist)
        savePlaylists()
    }

    func deletePlaylist(playlist: Playlist){
        guard let playlistIndex = PlaylistController.shared.playlists.index(of: playlist) else {
            return
        }
        PlaylistController.shared.playlists.remove(at: playlistIndex)
        savePlaylists()
    }
    
    private func fileURL() -> URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = path[0]
        let fileName = "playlists.json"
        let fullURL = documentDirectory.appendingPathComponent(fileName)
        return fullURL
    }
    
    func loadPlaylists(){
        let jd = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let playlists = try jd.decode([Playlist].self, from: data)
            self.playlists = playlists
        } catch let e {
            print("Error loading playlists: \(e)")
        }
    }
    
    func savePlaylists(){
        let je = JSONEncoder()
        do {
            let data = try je.encode(playlists)
            try data.write(to: fileURL())
        } catch let e {
            print("Error saving playlists: \(e)")
        }
    }
}
