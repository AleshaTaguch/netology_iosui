import Foundation
import UIKit

final class AppCoordinator: AppCoordinatorProtocol {
    var appTabBarControler: UITabBarController?
    
    var pinCodeCoordinator: PinCodeCoordinatorProtocol?
    
    var filesCoordinator: FilesCoordinatorProtocol?
    var settingsCoordinator: SettingsCoordinatorProtocol?
    
    var feedCoordinator: FeedCoordinatorProtocol?
    var profileCoordinator: ProfileCoordinatorProtocol?
    
    var audioCoordinator: AudioCoordinatorProtocol?
    var videoCoordinator: VideoCoordinatorProtocol?
    
    init(controller: UITabBarController?) {
        self.appTabBarControler = controller
    }
    
    func startApplication() {
        if let valueAppTabBarControler = appTabBarControler {
            pinCodeCoordinator = PinCodeCoordinator(controller: valueAppTabBarControler)
            pinCodeCoordinator?.start(mode: .enterPinMode) { [weak self] in
                guard let self = self else {return}
                self.startApplication2()
                self.pinCodeCoordinator = nil
            }
        }
    }
    
    func startApplication2() {
        if let valueAppTabBarControler = appTabBarControler {
            
            //создаем фабрику
            let appTabBarFactory = AppTabBarFactory()
            
            var navContrillersArray: [UINavigationController] = []
            
            // создаем контрроллер
            let filesNavController = appTabBarFactory.makeAppNavigationController(tabBarItemType: .files)
            //создаем координатор и передаем в него контроллер
            filesCoordinator = FilesCoordinator(controller: filesNavController)
            // стартуем координатор
            filesCoordinator?.start()
            navContrillersArray.append(filesNavController)
            
            // создаем контрроллер
            let settingNavController = appTabBarFactory.makeAppNavigationController(tabBarItemType: .settings)
            //создаем координатор и передаем в него контроллер
            settingsCoordinator = SettingsCoordinator(controller: settingNavController)
            // стартуем координатор
            settingsCoordinator?.start()
            navContrillersArray.append(settingNavController)

            /*
            // создаем контрроллер
            let feedNavController = appTabBarFactory.makeAppNavigationController(tabBarItemType: .feed)
            //создаем координатор и передаем в него контроллер
            feedCoordinator = FeedCoordinator(controller: feedNavController)
            // стартуем координатор
            feedCoordinator?.start()
            navContrillersArray.append(feedNavController)
            
            // создаем контрроллер
            let profileNavController = appTabBarFactory.makeAppNavigationController(tabBarItemType: .profile)
            //создаем координатор и передаем в него контроллер
            profileCoordinator = ProfileCoordinator(controller: profileNavController)
            // стартуем координатор
            profileCoordinator?.start()
            navContrillersArray.append(profileNavController)
            
            // создаем контроллер
            let audioNavController = appTabBarFactory.makeAppNavigationController(tabBarItemType: .audio)
            //создаем координатор и передаем в него контроллер
            audioCoordinator = AudioCoordinator(controller: audioNavController)
            // стартуем координатор
            audioCoordinator?.start()
            navContrillersArray.append(audioNavController)
            
            // создаем контроллер
            let videoNavController = appTabBarFactory.makeAppNavigationController(tabBarItemType: .video)
            //создаем координатор и передаем в него контроллер
            videoCoordinator = VideoCoordinator(controller: videoNavController)
            // стартуем координатор
            videoCoordinator?.start()
            navContrillersArray.append(videoNavController)
            
            */
            
            valueAppTabBarControler.viewControllers = navContrillersArray

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
