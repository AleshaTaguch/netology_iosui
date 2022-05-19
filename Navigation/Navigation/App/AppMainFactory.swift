
import Foundation
import UIKit


final class AppMainFactory {
    
    static let share: AppMainFactory = AppMainFactory()

    enum ModuleName {
        case login
        case profile
        case feed
    }
    
    enum TabBarItemType {
        case feed
        case profile
    }
    
    private init() {}
    
    public func makeAppNavigationController(tabBarItemType: TabBarItemType) -> UINavigationController {
        let navigationController = UINavigationController()
        switch tabBarItemType {
        case .feed:
            navigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house"), tag: 0)
            navigationController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        case .profile:
            navigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
            navigationController.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        }
        return navigationController
    }
    
    private func makeModuleFeed() -> UIViewController  {
        let feedViewController = FeedViewController()
        return feedViewController
    }
    
    private func makeModuleProfile() -> UIViewController   {
        return UIViewController()
    }
    
    private func makeModuleLogin() -> UIViewController  {
        let loginViewController = LoginViewController()
        loginViewController.loginCheckerDeligate = LoginFactory.share.makeLoginInpector()
        return loginViewController
    }
    
    func startModule(module: ModuleName) -> UIViewController {
        switch module {
        case .feed:
            return makeModuleFeed()
        case .profile:
            return makeModuleProfile()
        case .login:
            return makeModuleLogin()
        }
        
    }
        
}

