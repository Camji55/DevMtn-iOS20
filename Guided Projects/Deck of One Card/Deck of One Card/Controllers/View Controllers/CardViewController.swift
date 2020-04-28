//
//  CardViewController.swift
//  Deck of One Card
//
//  Created by Cameron Ingham on 7/16/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var cardImage: UIImageView!
    
    @IBAction func draw(_ sender: Any) {
        CardController.draw(numberOfCards: 1){ deck in
            guard let card = deck?.cards.first else {return}
            CardController.getImage(card: card){ image in
                self.cardImage.image = image
            }
        }
    }

}
