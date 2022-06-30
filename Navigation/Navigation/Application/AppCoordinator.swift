import Foundation
import UIKit
 
final class AppCoordinator: AppCoordinatorProtocol {
    var appTabBarControler: UITabBarController?
    
    var feedCoordinator: FeedCoordinatorProtocol?
    var profileCoordinator: ProfileCoordinatorProtocol?
    
    init(controller: UITabBarController?) {
        self.appTabBarControler = controller
    }
    
    func startApplication() {
        if let valueAppTabBarControler = appTabBarControler {
            
            //создаем фабрику
            let appTabBarFactory = AppTabBarFactory()
            
            // создаем контрроллер
            let feedNavController = appTabBarFactory.makeAppNavigationController(tabBarItemType: .feed)
            //создаем координатор и передаем в него контроллер
            feedCoordinator = FeedCoordinator(controller: feedNavController)
            // стартуем координатор
            feedCoordinator?.start()
            
            // создаем контрроллер
            let profileNavController = appTabBarFactory.makeAppNavigationController(tabBarItemType: .profile)
            //создаем координатор и передаем в него контроллер
            profileCoordinator = ProfileCoordinator(controller: profileNavController)
            // стартуем координатор
            profileCoordinator?.start()
            
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
