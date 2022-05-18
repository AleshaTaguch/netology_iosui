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
    var navigationController: UINavigationController?
    
    init(controller: UINavigationController?) {
        self.navigationController = controller
    }
    
    func start() {
        let loginViewController = LoginViewController()
        loginViewController.loginCheckerDeligate = myLoginFactory.share.makeLoginInpector()
        navigationController?.setViewControllers([loginViewController], animated: true)
    }

}
