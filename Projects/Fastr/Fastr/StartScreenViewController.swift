//
//  StartScreenViewController.swift
//  Fastr
//
//  Created by John Cody Thompson on 8/16/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {
    
    // MARK: - Interactions
    @IBAction func playButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toGame", sender: self)
    }
    @IBAction func howToButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toHowToPlay", sender: self)
    }

}
