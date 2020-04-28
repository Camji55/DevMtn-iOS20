//
//  RestaurantTableViewCell.swift
//  Restaurant Rater
//
//  Created by Cameron Ingham on 7/14/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

protocol RestaurantTableViewCellDelegate: class {
    func toggleButton(restaurant: Restaurant)
}

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    var restaurant: Restaurant? {
        didSet{
            updateViews()
        }
    }
    
    weak var delegate: RestaurantTableViewCellDelegate?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!

    @IBAction func toggleButton(_ sender: Any) {
        guard let restaurant = restaurant else {return}
        delegate?.toggleButton(restaurant: restaurant)
    }
    
    func updateViews(){
        guard let restaurant = restaurant else {return}
        nameLabel.text = restaurant.name
        let image = restaurant.isGood ? UIImage(named: "thumbs-up") : UIImage(named: "thumbs-down")
        rateButton.setBackgroundImage(image, for: .normal)
    }

}
