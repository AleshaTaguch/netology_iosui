//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by tertyshniy on 13.05.2022.
//

import Foundation
import UIKit
import StorageService

enum Event {
    case showPost(Post)
    case showInfo
}

protocol FeedCoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController? {get set}
    func start()
    func doEventHandle(with typeEvent: Event)
}


final class FeedCoordinator: FeedCoordinatorProtocol {
    weak var navigationController: UINavigationController?
    
    init(controller: UINavigationController?) {
        self.navigationController = controller
    }
    
    
    func start() {
        let feedViewController = FeedViewController()
        feedViewController.coordinatorDeligate = self
        navigationController?.setViewControllers([feedViewController], animated: true)
    }
    
    func doEventHandle(with typeEvent: Event) {
        switch typeEvent {
        case .showInfo:
            let infoViewController = InfoViewController()
            infoViewController.coordinatorDeligate = self
            navigationController?.present(infoViewController, animated: true, completion: nil)
       
        case .showPost(let currentPost):
            let postViewController = PostViewController()
            postViewController.post = currentPost
            postViewController.coordinatorDeligate = self
            navigationController?.pushViewController(postViewController, animated: true)
        }
        
    }
}

