//
//  PlaylistController.swift
//  MVC
//
//  Created by Cameron Ingham on 7/4/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CoreData

class PlaylistController {
    
    static let shared = PlaylistController()
    
    var playlists: [Playlist] {
        let fetchRequest: NSFetchRequest = Playlist.fetchRequest()
        var playlists = [Playlist]()
        do{
            playlists = try CoreDataStack.managedObjectContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        return playlists
    }
    
    func createPlaylist(name: String){
        let _ = Playlist(name: name)
        CoreDataManager.saveToPersistantStore()
    }

    func deletePlaylist(_ playlist: Playlist){
        CoreDataManager.delete(object: playlist)
        CoreDataManager.saveToPersistantStore()
    }
}
