//
//  JokeController.swift
//  Chuck Norris Jokes
//
//  Created by Cameron Ingham on 7/18/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

class JokeController {
    
    private static let baseURL = URL(string: "https://api.chucknorris.io/jokes")
    
    static func getCategories(completion: @escaping ([String]) -> Void){
        guard var url = baseURL else {
            completion([])
            return
        }
        
        url.appendPathComponent("categories")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([])
            }
            
            guard let data = data else {
                completion([])
                return
            }
            
            let jd = JSONDecoder()
            do {
                let categories = try jd.decode([String].self, from: data)
                completion(categories.sorted())
            } catch {
                print(error.localizedDescription)
                completion([])
                return
            }
        }
        dataTask.resume()
    }
    
    static func getRandomJoke(category: String, completion: @escaping (Joke?) -> Void){
        guard var url = baseURL else {
            completion(nil)
            return
        }
        
        url.appendPathComponent("random")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let categoryQueryItem = URLQueryItem(name: "category", value: category)
        components?.queryItems = [categoryQueryItem]
        
        guard let requestURL = components?.url else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            let jd = JSONDecoder()
            do {
                let joke = try jd.decode(Joke.self, from: data)
                completion(joke)
            } catch {
                print(error.localizedDescription)
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }
    
}
