//
//  Setting.swift
//  Settings
//
//  Created by Cameron Ingham on 7/9/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class Setting {
    let image: UIImage
    let name: String
    var enabled: Bool = false
    
    init(name: String, image: UIImage){
        self.image = image
        self.name = name
    }

}
