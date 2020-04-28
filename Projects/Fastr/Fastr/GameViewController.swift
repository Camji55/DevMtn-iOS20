//
//  GameViewController.swift
//  Fastr
//
//  Created by John Cody Thompson on 8/16/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Properties
    let gameController = GameController()
    
    // MARK: - Outlets
    @IBOutlet weak var player1Button: UIButton!
    @IBOutlet weak var player2Button: UIButton!
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        player2Label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        gameController.start(gameViewController: self)
    }
    
    // MARK: - Interactions
    @IBAction func player1ButtonTapped(_ sender: UIButton) {
        if(player1Label.text == "TAP!") {
            gameController.winner(gameViewController: self, winner: sender, loser: player2Button)
        } else {
            gameController.winner(gameViewController: self, winner: player2Button, loser: sender)
        }
    }
    
    @IBAction func player2ButtonTapped(_ sender: UIButton) {
        if(player2Label.text == "TAP!") {
            gameController.winner(gameViewController: self, winner: sender, loser: player1Button)
        } else {
            gameController.winner(gameViewController: self, winner: player1Button, loser: sender)
        }
    }

}
