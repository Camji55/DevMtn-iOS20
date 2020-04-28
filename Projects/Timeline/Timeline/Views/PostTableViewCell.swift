//
//  PostTableViewCell.swift
//  Timeline
//
//  Created by Cameron Ingham on 8/7/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var post: Post? {
        didSet {
            updateViews()
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    // MARK: - Lifecycle Functions
    override func awakeFromNib() {
        postImage.layer.cornerRadius = 5
        postImage.layer.masksToBounds = true
        bgView.layer.cornerRadius = 5
        bgView.layer.shadowColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1).cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 4)
        bgView.layer.shadowOpacity = 0.75
        bgView.layer.shadowRadius = 4.0
        self.contentView.layer.masksToBounds = true
    }
    
    // MARK: - Functions
    func updateViews() {
        guard let post = post else {return}
        postImage.image = post.photo ?? UIImage(named: "NoImage") ?? UIImage()
    }
    
    
}
