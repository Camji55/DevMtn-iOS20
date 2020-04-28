//
//  GameController.swift
//  Fastr
//
//  Created by Cameron Ingham on 8/16/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class GameController {
    
    // MARK: - Properties
    var hasWinner: Bool = false
    
    // MARK: - Functions
    func start(gameViewController: GameViewController){
        gameViewController.player1Label.isHidden = false
        gameViewController.player2Label.isHidden = false
        gameViewController.player1Label.text = "Ready"
        gameViewController.player2Label.text = "Ready"
        gameViewController.player1Button.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        gameViewController.player2Button.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        gameViewController.player1Button.setTitle("", for: .normal)
        gameViewController.player2Button.setTitle("", for: .normal)
        gameViewController.player1Button.isUserInteractionEnabled = true
        gameViewController.player2Button.isUserInteractionEnabled = true
        
        let randomTime = Double.random(in: 0...10)
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if self.hasWinner == false {
                gameViewController.player1Label.text = "Ready"
                gameViewController.player2Label.text = "Ready"
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.hasWinner == false {
                gameViewController.player1Label.text = "Set"
                gameViewController.player2Label.text = "Set"
                generator.impactOccurred()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 + randomTime) {
            if self.hasWinner == false {
                gameViewController.player1Label.text = "TAP!"
                gameViewController.player2Label.text = "TAP!"
                generator.impactOccurred()
            }
        }
        hasWinner = false
    }
    
    func winner(gameViewController: GameViewController, winner: UIButton, loser: UIButton) {
        winner.backgroundColor = UIColor(red:0.29, green:0.56, blue:0.89, alpha:1.0)
        winner.setTitle("You Win!", for: .normal)
        winner.setTitleColor(UIColor.white, for: .normal)
        winner.isUserInteractionEnabled = false
        
        loser.backgroundColor = UIColor(red:0.61, green:0.61, blue:0.61, alpha:1.0)

        loser.setTitle("You Lose!", for: .normal)
        loser.setTitleColor(UIColor.white, for: .normal)
        loser.isUserInteractionEnabled = false
        
        gameViewController.player1Label.isHidden = true
        gameViewController.player2Label.isHidden = true
        
        gameViewController.player2Button.titleLabel?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        let alert = UIAlertController(title: "Play Again?", message: nil, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            gameViewController.gameController.start(gameViewController: gameViewController)
        }
        let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in
            gameViewController.dismiss(animated: true, completion: nil)
        }
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        gameViewController.present(alert, animated: true, completion: nil)
        hasWinner = true
    }
    
}
