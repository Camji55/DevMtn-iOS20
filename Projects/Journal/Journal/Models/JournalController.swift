//
//  JournalController.swift
//  Journal
//
//  Created by Cameron Ingham on 7/5/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

class JournalController {
    static let shared = JournalController()
    
    var journals: [Journal] = []
    
    func createJournal(title: String){
        let newJournal = Journal(title: title)
        journals.append(newJournal)
        saveJournals()
    }
    
    func deleteJournal(journal: Journal){
        guard let journalIndex = journals.index(of: journal) else {
            return
        }
        journals.remove(at: journalIndex)
        saveJournals()
    }
    
    private func fileURL() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = path[0]
        let fileName = "journals.json"
        let fullURL = documentDirectory.appendingPathComponent(fileName)
        print(fullURL)
        return fullURL
    }
    
    func saveJournals(){
        let je = JSONEncoder()
        do {
            let data = try je.encode(journals)
            try data.write(to: fileURL())
        } catch let e {
            print("There was an error saving the journals: \(e)")
        }
    }
    
    func loadJournals(){
        let jd = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let journals = try jd.decode([Journal].self, from: data)
            JournalController.shared.journals = journals
        } catch let e {
            print("There was an error loading the journals: \(e)")
        }
    }
}
