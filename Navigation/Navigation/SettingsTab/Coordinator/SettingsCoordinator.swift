import Foundation
import UIKit

final class SettingsCoordinator: SettingsCoordinatorProtocol {
    weak var navigationController: UINavigationController?
    
    var pinCodeCoordinator: PinCodeCoordinatorProtocol?
    
    init(controller: UINavigationController?) {
        self.navigationController = controller
    }
    
    func start() {
        let settingsViewController = SettingsViewController()
        settingsViewController.coordinatorDeligate = self
        navigationController?.setViewControllers([settingsViewController], animated: true)
    }
    
    func doEventHandle(with typeEvent: EventSettings) {
        
        switch typeEvent {
        case .showPinCodeView:
            if let valueNavigationController = navigationController {
                
                pinCodeCoordinator = PinCodeCoordinator(controller: valueNavigationController)
                pinCodeCoordinator?.start(mode: .createPinMode)  { [weak self] in
                    guard let self = self else {return}
                    self.pinCodeCoordinator = nil
                }
            }

        case .changeSortDirection:
            print("changeSortDirection")
            
            /*
            let postViewController = PostViewController()
            postViewController.post = currentPost
            postViewController.coordinatorDeligate = self
            navigationController?.pushViewController(postViewController, animated: true)
             */

        }
    }
}

