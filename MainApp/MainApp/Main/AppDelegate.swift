//
//  AppDelegate.swift
//  MyPokedex
//
//  Created by Christian Adiputra on 28/02/23.
//

import UIKit
import Provider

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupFeatureProviders()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        guard let appWindow = window else {
            fatalError("failed to create window")
        }
        
        let vc = MovieProvider.instance.createMovieVc()
//        let tabBarController = MainTabBarController()
        appWindow.rootViewController = UINavigationController(rootViewController: vc)
        appWindow.makeKeyAndVisible()
        
        return true
        
        
    }
    
}

