import Foundation
import UIKit

struct TabBarItemTypeConfig {
    var titleTabBar: String
    var defaultImage: String
    var selectedImage: String
}

enum TabBarItemType {
    case feed
    case files
    case settings
    case profile
    case audio
    case video
    
    var config: TabBarItemTypeConfig {
        switch self {
        case .feed:
            return TabBarItemTypeConfig(titleTabBar: "Feed", defaultImage: "house", selectedImage: "house.fill")
        case .profile:
            return TabBarItemTypeConfig(titleTabBar: "Profile", defaultImage: "person", selectedImage: "person.fill")
        case .audio:
            return TabBarItemTypeConfig(titleTabBar: "Audio", defaultImage: "music.note", selectedImage: "music.note")
        case .video:
            return TabBarItemTypeConfig(titleTabBar:  "Video", defaultImage: "video", selectedImage: "video.fill")
        case .files:
            return TabBarItemTypeConfig(titleTabBar:  "Files", defaultImage: "folder", selectedImage: "folder.fill")
        case .settings:
            return TabBarItemTypeConfig(titleTabBar:  "Settings", defaultImage: "gearshape", selectedImage: "gearshape.fill")
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

