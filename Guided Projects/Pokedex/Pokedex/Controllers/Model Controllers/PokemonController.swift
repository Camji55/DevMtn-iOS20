//
//  PokemonController.swift
//  Pokedex
//
//  Created by Cameron Ingham on 7/17/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class PokemonController {
    
    static var baseURL = URL(string: "http://pokeapi.co/api/v2/")
    
    static func getPokemon(_ nameOrId: String, completion: @escaping (Pokemon?) -> Void){
        guard var baseURL = baseURL else {
            completion(nil)
            return
        }
        
        baseURL.appendPathComponent("pokemon")
        baseURL.appendPathComponent(nameOrId)
        
        var request = URLRequest(url: baseURL)
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
            do {
                guard let pokemonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    completion(nil)
                    return
                }
                let pokemon = Pokemon(pokeDicktionary: pokemonDictionary)
                completion(pokemon)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }
        dataTask.resume()
    }
    
    static func getImage(for pokemon: Pokemon, completion: @escaping (UIImage?) -> Void){
        guard let url = URL(string: pokemon.imageURL) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
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
            
            completion(UIImage(data: data))
        }
        dataTask.resume()
    }
}
