//
//  AppDelegate.swift
//  TodayNew
//
//  Created by MOMO on 2020/10/16.
//  Copyright © 2020 MOMO. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible() 
        
        return true
    }

    // MARK: UISceneSession Lifecycle



}

