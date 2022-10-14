import Foundation
import UIKit

struct TabBarItemTypeConfig {
    var titleTabBar: String
    var defaultImage: String
    var selectedImage: String
}

enum TabBarItemType {
    case feed
    case profile
    
    var config: TabBarItemTypeConfig {
        switch self {
        case .feed:
            return TabBarItemTypeConfig(titleTabBar: "Feed", defaultImage: "house", selectedImage: "house.fill")
        case .profile:
            return TabBarItemTypeConfig(titleTabBar: "Profile", defaultImage: "person", selectedImage: "person.fill")
        }
    }
}

final class AppTabBarFactory {
    
    public func makeAppNavigationController(tabBarItemType: TabBarItemType) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: tabBarItemType.config.titleTabBar, image: UIImage(systemName: tabBarItemType.config.defaultImage), tag: 0)
        navigationController.tabBarItem.selectedImage = UIImage(systemName: tabBarItemType.config.selectedImage)
        return navigationController
    }
    
}

