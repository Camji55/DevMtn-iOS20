//
//  FriendController.swift
//  FriendRater
//
//  Created by Cameron Ingham on 7/7/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

class FriendController {
    
    static let shared = FriendController()
    
    var friends: [Friend] = []
    
    func createFriend(name: String, rating: Int){
        let newFriend = Friend(name: name, rating: rating)
        friends.append(newFriend)
        saveFriends()
    }
    
    func deleteFriend(friend: Friend){
        guard let friendIndex = friends.index(of: friend) else {
            return
        }
        friends.remove(at: friendIndex)
        saveFriends()
    }
    
    func updateFriend(friend: Friend, name: String, rating: Int) {
        friend.name = name
        friend.rating = rating
        saveFriends()
    }
    
    private func fileURL() -> URL{
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentDirectory.appendingPathComponent("friends.json")
    }
    
    func saveFriends(){
        let je = JSONEncoder()
        do {
            let data = try je.encode(friends)
            try data.write(to: fileURL())
        } catch let e{
            print("Error saving friends. \(e.localizedDescription)")
        }
    }
    
    func loadFriends(){
        let jd = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let friends = try jd.decode([Friend].self, from: data)
            self.friends = friends
        } catch let e{
            print("Error loading friends. \(e.localizedDescription)")
        }
    }
    
}
