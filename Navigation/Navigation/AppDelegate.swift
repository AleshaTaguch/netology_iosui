//
//  AppDelegate.swift
//  Navigation
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let statTBController = UITabBarController()

        let feedNavController = UINavigationController()
        let feedTabImage = UIImage(named: "FeedImage")
        feedNavController.tabBarItem = UITabBarItem(title: "Feed", image: feedTabImage, tag: 0)
        
        let feedViewController = FeedViewController()
        feedNavController.setViewControllers([feedViewController], animated: true)
        
        let profileNavController = UINavigationController()
        let profileTabImage = UIImage(named: "ProfileImage")
        profileNavController.tabBarItem = UITabBarItem(title: "Profile", image: profileTabImage, tag: 1)

        let profileViewController = ProfileViewController()
        profileNavController.setViewControllers([profileViewController], animated: true)

        statTBController.viewControllers = [feedNavController,profileNavController]
        
        window?.rootViewController = statTBController
        
        window?.makeKeyAndVisible()
        
        return true
    }
    


    // MARK: UISceneSession Lifecycle
/*
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
*/

}

