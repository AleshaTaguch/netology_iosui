import Foundation
import UIKit

final class ProfileCoordinator: ProfileCoordinatorProtocol {
    weak var navigationController: UINavigationController?
    weak var databaseCoordinator: DatabaseCoordinatorProtocol?
    
    init(controller: UINavigationController?, databaseCoordinator: DatabaseCoordinatorProtocol?) {
        self.navigationController = controller
        self.databaseCoordinator = databaseCoordinator
    }
    
    func start() {
        let loginViewController = LoginViewController()
        loginViewController.databaseCoordinator = self.databaseCoordinator
        loginViewController.loginCheckerDeligate = LoginFactory.share.makeLoginInpector()
        loginViewController.doEventWhenSuccess = { [weak self] (UserService, userName) in
            guard let self = self else {return}
            self.doEventSuccessLogin(currentUser: UserService,  currentUserName: userName)
        }
        
     navigationController?.setViewControllers([loginViewController], animated: true)
    }

    func doEventSuccessLogin(currentUser currentUserService: UserService, currentUserName: String) {
        let profileViewController = ProfileViewController(currentUser: currentUserService, currentUserName: currentUserName)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.setViewControllers([profileViewController], animated: true)
    }
}
