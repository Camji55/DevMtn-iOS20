//
//  UserController.swift
//  Favorite App
//
//  Created by Cameron Ingham on 7/18/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

class UserController {
    
    static var shared = UserController()
    var users: [User] = []
    
    let baseURL = URL(string: "https://favoriteapp-375c6.firebaseio.com")
    
    func getUsers(completion: @escaping (Bool) -> Void) {
        guard var url = baseURL else {
            completion(false)
            return
        }
        
        url.appendPathComponent("users")
        url.appendPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            }
            
            guard let data = data else {
                completion(false)
                return
            }
            
            let jd = JSONDecoder()
            
            do {
                let usersDictionary = try jd.decode([String: User].self, from: data)
                var users = [User]()
                for (_, value) in usersDictionary {
                    users.append(value)
                }
                self.users = users
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        dataTask.resume()
    }
    
    func addUsers(username: String, favoriteApp: String, completion: @escaping (Bool) -> Void) {
        guard var url = baseURL else {
            completion(false)
            return
        }
        
        url.appendPathComponent("users")
        url.appendPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let user = User(favoriteApp: favoriteApp, name: username)
        let je = JSONEncoder()
        
        do {
            let data = try je.encode(user)
            request.httpBody = data
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            }
            completion(true)
        }
        dataTask.resume()
    }
}
