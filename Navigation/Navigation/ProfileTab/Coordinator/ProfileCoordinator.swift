//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by tertyshniy on 19.05.2022.
//

import Foundation
import UIKit

protocol ProfileCoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController? {get set}
    func start()
}


final class ProfileCoordinator: ProfileCoordinatorProtocol {
    weak var navigationController: UINavigationController?
    
    init(controller: UINavigationController?) {
        self.navigationController = controller
    }
    
    func start() {
        let loginViewController = LoginViewController()
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
