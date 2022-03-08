import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let statTBController = UITabBarController()
    
    let feedNavController = UINavigationController()
    let feedViewController = FeedViewController()
    
    let profileNavController = UINavigationController()
    let profileViewController = ProfileViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        feedNavController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house"), tag: 0)
        feedNavController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        feedNavController.setViewControllers([feedViewController], animated: true)
        
        profileNavController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
        profileNavController.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        profileNavController.setViewControllers([profileViewController], animated: true)      

        statTBController.viewControllers = [feedNavController,profileNavController]
        statTBController.tabBar.backgroundColor = .systemGray6
        statTBController.tabBar.layer.borderWidth = 0.5
        statTBController.tabBar.layer.borderColor = UIColor.lightGray.cgColor
    
        
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

