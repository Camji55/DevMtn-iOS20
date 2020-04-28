//
//  EntryController.swift
//  Journal
//
//  Created by Cameron Ingham on 7/4/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

class EntryController {
    
    static func createEntry(title: String, bodyText: String, tag: String, journal: Journal){
        let newEntry = Entry(title: title, timeStamp: Date(), bodyText: bodyText, tag: tag)
        journal.entries.append(newEntry)
        JournalController.shared.saveJournals()
    }

    static func deleteEntry(entry: Entry, journal: Journal){
        guard let entryIndex = journal.entries.index(of: entry) else {
            return
        }
        journal.entries.remove(at: entryIndex)
        JournalController.shared.saveJournals()
    }

}
