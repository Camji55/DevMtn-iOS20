//
//  AppDelegate.swift
//  Timeline
//
//  Created by Cameron Ingham on 8/7/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit
import CloudKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
        
        UIApplication.shared.registerForRemoteNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: PostController.PostsChangedNotification, object: self)
            NotificationCenter.default.post(name: PostController.PostCommentsChangedNotification, object: self)
        }
        PostController.shared.loadPosts { (success, error) in
            if success {
                completionHandler(UIBackgroundFetchResult.newData)
            }
        }
    }

}

