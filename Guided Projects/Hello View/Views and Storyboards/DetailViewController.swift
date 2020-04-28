//
//  DetailViewController.swift
//  Views and Storyboards
//
//  Created by Cameron Ingham on 7/2/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBAction func touchUpInside(_ sender: UIButton) {
        view.backgroundColor = UIColor.red
    }
    
    @IBAction func touchDown(_ sender: UIButton) {
        view.backgroundColor = UIColor.blue
    }
    
    @IBAction func touchDragInside(_ sender: UIButton) {
        view.backgroundColor = UIColor.yellow
    }
    
    @IBAction func touchDownRepeat(_ sender: UIButton) {
        view.backgroundColor = UIColor.orange
    }
    
    @IBAction func touchDragOutside(_ sender: UIButton) {
        view.backgroundColor = UIColor.cyan
    }
    
}
