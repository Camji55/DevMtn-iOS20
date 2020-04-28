//
//  QuoteViewController.swift
//  Kanye Quotes
//
//  Created by Cameron Ingham on 7/12/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class QuoteViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var kanyeSayLabel: UILabel!
    @IBOutlet weak var kanyeImage: UIImageView!
    
    var quote: Quote? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    func updateViews(){
        guard let quote = quote else {return}
        quoteLabel.text = quote.quote
        kanyeSayLabel.text = quote.isKanye ? "YES" : "NO"
        kanyeImage.image = quote.isKanye ? UIImage(named: "happyKanye") : UIImage(named: "sadKanye")
    }


}
