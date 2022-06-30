import Foundation
import UIKit
 
final class AppCoordinator: AppCoordinatorProtocol {
    var appTabBarControler: UITabBarController?
    
    var feedCoordinator: FeedCoordinatorProtocol?
    var profileCoordinator: ProfileCoordinatorProtocol?
    
    var audioCoordinator: AudioCoordinatorProtocol?
    var videoCoordinator: VideoCoordinatorProtocol?
    
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
            
            
            // создаем контроллер
            let audioNavController = appTabBarFactory.makeAppNavigationController(tabBarItemType: .audio)
            //создаем координатор и передаем в него контроллер
            audioCoordinator = AudioCoordinator(controller: audioNavController)
            // стартуем координатор
            audioCoordinator?.start()
            
            // создаем контроллер
            let videoNavController = appTabBarFactory.makeAppNavigationController(tabBarItemType: .video)
            //создаем координатор и передаем в него контроллер
            videoCoordinator = VideoCoordinator(controller: videoNavController)
            // стартуем координатор
            videoCoordinator?.start()
            
            valueAppTabBarControler.viewControllers = [feedNavController,
                                                       profileNavController,
                                                       audioNavController,
                                                       videoNavController]
            
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
