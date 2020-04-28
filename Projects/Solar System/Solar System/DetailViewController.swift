//
//  DetailViewController.swift
//  Solar System
//
//  Created by Cameron Ingham on 7/3/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var distanceFromSun: UILabel!
    @IBOutlet weak var distanceFromEarth: UILabel!
    @IBOutlet weak var planetDescription: UILabel!
    
    var planet = Planet(name: "", image: UIImage(named: "Mercury")!, description: "", distanceFromSun: "", distanceFromEarth: "")

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        title = planet.name
        planetImage.image = planet.image
        distanceFromSun.text = planet.distanceFromSun
        distanceFromEarth.text = planet.distanceFromEarth
        planetDescription.text = planet.description
        navigationController?.navigationBar.tintColor = UIColor(red: 46/255, green: 134/255, blue: 112/255, alpha: 1.0)
    }


}

