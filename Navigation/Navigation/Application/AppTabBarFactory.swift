import Foundation
import UIKit


final class AppTabBarFactory {

    enum TabBarItemType {
        case feed
        case profile
        case audio
        case video
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
        case .audio:
            navigationController.tabBarItem = UITabBarItem(title: "Audio", image: UIImage(systemName: "music.note"), tag: 0)
            navigationController.tabBarItem.selectedImage = UIImage(systemName: "music.note")
        case .video:
            navigationController.tabBarItem = UITabBarItem(title: "Video", image: UIImage(systemName: "video"), tag: 0)
            navigationController.tabBarItem.selectedImage = UIImage(systemName: "video.fill")
        }
        return navigationController
    }
    
}

