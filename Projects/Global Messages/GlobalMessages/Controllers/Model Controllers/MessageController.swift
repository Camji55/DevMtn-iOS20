//
//  PostController.swift
//  Post
//
//  Created by Cameron Ingham on 7/16/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import UIKit

class MessageController {
    
    static let baseURL = URL(string: "https://devmtn-posts.firebaseio.com/posts.json")
    
    static func messages(completion: @escaping ([Message]?, Bool) -> Void){
        toggleNetworkIndicator(true)
        guard let url = baseURL else {return}
        let jd = JSONDecoder()
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil && data == nil {
                print(error?.localizedDescription ?? "No data")
                toggleNetworkIndicator(false)
                completion(nil, false)
            }
            do {
                let messagesDictionary = try jd.decode([String: Message].self, from: data!)
                
                let messages = messagesDictionary.compactMap{ $1 }
                toggleNetworkIndicator(false)
                completion(messages, true)
            } catch {
                toggleNetworkIndicator(false)
                completion(nil, false)
            }
        }
        task.resume()
    }
    
    static func create(message: Message, completion: @escaping (Bool) -> Void){
        toggleNetworkIndicator(true)
        guard let url = baseURL else {return}
        let je = JSONEncoder()
        do {
            let data = try je.encode(message)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = data
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if error == nil {
                    print(error?.localizedDescription ?? "No data")
                    toggleNetworkIndicator(false)
                    completion(false)
                }
                toggleNetworkIndicator(false)
                completion(true)
            }
            task.resume()
        } catch {
            print(error)
            toggleNetworkIndicator(false)
            completion(false)
        }
    }
    
    private static func toggleNetworkIndicator(_ show: Bool){
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = show
        }
    }
    
}
