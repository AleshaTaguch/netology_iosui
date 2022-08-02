import UIKit
import FirebaseCore
import FirebaseAuth


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
        
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let appTabBarController: UITabBarController = UITabBarController()
        appCoordinator = AppCoordinator(controller: appTabBarController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appTabBarController
        window?.makeKeyAndVisible()
        
        appCoordinator?.startApplication()
                
        let appConfiguration: AppConfiguration = AppConfiguration.randomURL
        NetworkManager.URLSessionDataTask(appConfig: appConfiguration, completion: nil)
        
        FirebaseApp.configure()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        do {
            try FirebaseAuth.Auth.auth().signOut()
        } catch {
            print("Erorr when FirebaseAuth.Auth.auth().signOut(): \(error.localizedDescription)")
        }
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

