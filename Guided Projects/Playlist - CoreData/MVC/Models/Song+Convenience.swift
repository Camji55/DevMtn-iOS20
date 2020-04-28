//
//  Song+Convenience.swift
//  MVC
//
//  Created by Cameron Ingham on 7/11/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import CoreData

extension Song {
    convenience init(name: String, artist: String, playlist: Playlist, context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.name = name
        self.artist = artist
        self.playlist = playlist
    }
}
