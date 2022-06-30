import Foundation
import UIKit


final class AppTabBarFactory {

    enum TabBarItemType {
        case feed
        case profile
    }
    
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
    
}

