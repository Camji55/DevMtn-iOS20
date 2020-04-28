//
//  ActivityIndicatorManager.swift
//  Timeline
//
//  Created by Cameron Ingham on 8/10/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicatorManager {
    
    // MARK: - Functions
    static func setNetworkActivityIndicator(visible: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = visible
        }
    }
    
}
