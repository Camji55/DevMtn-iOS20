//
//  QuoteTableViewCell.swift
//  Kanye Quotes
//
//  Created by Cameron Ingham on 7/12/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var kanyeButton: UIButton!
    
    var quote: Quote? {
        didSet{
            updateViews()
        }
    }
    
    @IBAction func kanyeTapped(_ sender: Any) {
        guard let quote = quote else {return}
        QuoteController.toggleKanye(quote: quote)
    }
    
    func updateViews(){
        guard let quote = quote else {return}
        quoteLabel.text = quote.quote
        quote.isKanye ? kanyeButton.setBackgroundImage(UIImage(named: "yesKanye"), for: .normal) : kanyeButton.setBackgroundImage(UIImage(named: "noKanye"), for: .normal)
    }
    
}
