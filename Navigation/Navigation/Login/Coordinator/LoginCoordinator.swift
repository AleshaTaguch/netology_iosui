//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by tertyshniy on 19.05.2022.
//

import Foundation
import UIKit

protocol LoginCoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController? {get set}
    func start()
}


final class LoginCoordinator: LoginCoordinatorProtocol {
    weak var navigationController: UINavigationController?
    
    init(controller: UINavigationController?) {
        self.navigationController = controller
    }
    
    func start() {
        let loginViewController = LoginViewController()
        loginViewController.loginCheckerDeligate = LoginFactory.share.makeLoginInpector()
        loginViewController.doEventWhenSuccess = {(UserService, userName) in
            //if let self = self {
                self.doEventSuccessLogin(currentUser: UserService,  currentUserName: userName)
            //}
        }
        
        navigationController?.setViewControllers([loginViewController], animated: true)
    }

    func doEventSuccessLogin(currentUser currentUserService: UserService, currentUserName: String) {
        let profileViewController = ProfileViewController(currentUser: currentUserService, currentUserName: currentUserName)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.setViewControllers([profileViewController], animated: true)
    }
}
