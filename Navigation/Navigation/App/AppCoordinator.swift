import Foundation
import UIKit
 
final class AppCoordinator: AppCoordinatorProtocol {
    var appTabBarControler: UITabBarController?
    
    init(controller: UITabBarController?) {
        self.appTabBarControler = controller
    }
    
    func startApplication() {
        if let valueAppTabBarControler = appTabBarControler {
            
            // создаем контрроллер
            let feedNavController = AppMainFactory.share.makeAppNavigationController(tabBarItemType: .feed)
            //создаем координатор и передаем в него контроллер
            let feedCoordinator = FeedCoordinator(controller: feedNavController)
            // стартуем координатор
            feedCoordinator.start()
            
            // создаем контрроллер
            let profileNavController = AppMainFactory.share.makeAppNavigationController(tabBarItemType: .profile)
            //создаем координатор и передаем в него контроллер
            let loginCoordinator = LoginCoordinator(controller: profileNavController)
            // стартуем координатор
            loginCoordinator.start()
            
            valueAppTabBarControler.viewControllers = [feedNavController,profileNavController]
            
            valueAppTabBarControler.tabBar.backgroundColor = .systemGray6
            valueAppTabBarControler.tabBar.layer.borderWidth = 0.5
            valueAppTabBarControler.tabBar.layer.borderColor = UIColor.lightGray.cgColor
            #if DEBUG
            valueAppTabBarControler.tabBar.layer.borderWidth = 5
            valueAppTabBarControler.tabBar.layer.borderColor = UIColor.red.cgColor
            #endif
        }
    }
}
