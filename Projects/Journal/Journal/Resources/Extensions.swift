//
//  Extensions.swift
//  Journal
//
//  Created by Cameron Ingham on 7/6/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
