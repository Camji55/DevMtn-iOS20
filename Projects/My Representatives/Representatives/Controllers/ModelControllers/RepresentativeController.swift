//
//  RepresentativeController.swift
//  Representatives
//
//  Created by Cameron Ingham on 7/19/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class RepresentativeController {
    
    private static var baseURL = URL(string: "https://whoismyrepresentative.com/getall_mems.php?zip=98374&output=json")
    
    static func getRepresentatives(fromZip: String, completion: @escaping ([Representative]?) -> Void){
        guard let url = baseURL else {return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let zipQueryItem = URLQueryItem(name: "zip", value: fromZip)
        let outputQueryItem = URLQueryItem(name: "output", value: "json")
        components?.queryItems = [zipQueryItem, outputQueryItem]
        guard let newURL = components?.url else {return}
        
        var request = URLRequest(url: newURL)
        request.httpMethod = "GET"
        
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
                let results = try jd.decode(topLevelDictionary.self, from: data)
                completion(results.results)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
            
        }
        dataTask.resume()
    }
    
}
