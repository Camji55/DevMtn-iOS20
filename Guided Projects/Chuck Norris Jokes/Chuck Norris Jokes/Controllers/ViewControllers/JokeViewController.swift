//
//  JokeViewController.swift
//  Chuck Norris Jokes
//
//  Created by Cameron Ingham on 7/18/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class JokeViewController: UIViewController {
    
    var category: String = ""
    
    override func viewDidLoad() {
        title = category.capitalized
    }

    @IBOutlet weak var jokeButton: UIButton!
    @IBOutlet weak var jokeLabel: UILabel!
    
    @IBAction func newJoke(_ sender: Any) {
        JokeController.getRandomJoke(category: category) { (joke) in
            DispatchQueue.main.async {
                guard let joke = joke else {return}
                self.jokeLabel.text = joke.joke
            }
        }
    }
    
}
