//
//  iTunesItemController.swift
//  iTunes Search
//
//  Created by Cameron Ingham on 7/19/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class iTunesItemController {
    
    private static var baseURL = URL(string: "https://itunes.apple.com")

    static func getItunesItems(for searchTerm: String, completion: @escaping ([iTunesItem]?) -> Void){
        guard var url = baseURL else {
            completion(nil)
            return
        }
        
        url.appendPathComponent("search")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let mediaQueryItem = URLQueryItem(name: "media", value: "music")
        components?.queryItems = [searchQueryItem, mediaQueryItem]
        
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
                let topLevelDictionary = try jd.decode(TopLevelDictionary.self, from: data)
                completion(topLevelDictionary.results)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
            
            
        }
        dataTask.resume()
    }
    
    static func getAlbumCover(for iTunesItem: iTunesItem, completion: @escaping (UIImage?) -> Void){

        let url = URL(string: iTunesItem.albumCover)
        
        guard let myurl = url else {return}
        
        var request = URLRequest(url: myurl)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            completion(UIImage(data: data))

        }
        dataTask.resume()
    }
    
}
