//
//  CardController.swift
//  Deck of One Card
//
//  Created by Cameron Ingham on 7/16/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import UIKit

class CardController {
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/")
    
    static func draw(numberOfCards: Int, completion: @escaping (Deck?) -> Void){
        guard let url = baseURL else {
            completion(nil)
            return
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let countQueryItem = URLQueryItem(name: "count", value: "\(numberOfCards)")
        components?.queryItems = [countQueryItem]
        
        guard let requestURL = components?.url else {
            completion(nil)
            return
        }
        let data = try! Data(contentsOf: requestURL)
        let jd = JSONDecoder()
        let deck = try! jd.decode(Deck.self, from: data)
        completion(deck)
    }
    
    static func getImage(card: Card, completion: @escaping (UIImage?) -> Void) {
        guard let urlForImage = URL(string: card.image) else {
            completion(nil)
            return
        }
        let data = try! Data(contentsOf: urlForImage)
        completion(UIImage(data: data))
    }
}
