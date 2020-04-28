//
//  AppDelegate.swift
//  Power Nap Timer
//
//  Created by Cameron Ingham on 7/10/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (success, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if success {
                print("We can send alerts.")
            }
        }
        
        return true
    }

}

