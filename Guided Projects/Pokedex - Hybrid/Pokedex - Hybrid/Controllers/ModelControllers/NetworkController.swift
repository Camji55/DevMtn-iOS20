//
//  NetworkController.swift
//  Pokedex - Hybrid
//
//  Created by Cameron Ingham on 7/24/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

class NetworkController: NSObject {
    
    @objc static func performRequest(for url: URL,
                                     httpMethod: String,
                                     urlParameters: [String : String]? = nil,
                                     body: Data? = nil,
                                     completion: ((Data?, Error?) -> Void)? = nil) {
        
        // Build our entire URL
        
        let requestURL = self.url(byAdding: urlParameters, to: url)
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod
        request.httpBody = body
        
        // Create and "resume" (a.k.a. run) the task
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            completion?(data, error)
        }
        
        dataTask.resume()
    }
    
    @objc static func url(byAdding parameters: [String : String]?,
                          to url: URL) -> URL {
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters?.flatMap({ URLQueryItem(name: $0.0, value: $0.1) })
        
        guard let url = components?.url else {
            fatalError("URL optional is nil")
        }
        return url
    }
}
