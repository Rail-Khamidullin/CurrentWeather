//
//  AppDelegate.swift
//  CurrentWeatherFinal
//
//  Created by Rail on 03.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = ViewController()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }
}

