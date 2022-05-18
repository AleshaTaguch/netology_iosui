//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by tertyshniy on 13.05.2022.
//

import Foundation
import UIKit


protocol FeedCoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController? {get set}
    func start()
}


final class FeedCoordinator: FeedCoordinatorProtocol {
    var navigationController: UINavigationController?
    
    init(controller: UINavigationController?) {
        self.navigationController = controller
    }
    
    
    func start() {
        let feedViewController = FeedViewController()
        navigationController?.setViewControllers([feedViewController], animated: true)
    }

}

