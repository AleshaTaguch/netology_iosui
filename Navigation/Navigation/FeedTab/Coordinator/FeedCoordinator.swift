import Foundation
import UIKit
import StorageService

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
    
    func doEventHandle(with typeEvent: EventFeed) {
        switch typeEvent {
        case .showInfo:
            let infoViewController = InfoViewController()
            navigationController?.present(infoViewController, animated: true, completion: nil)
       
        case .showPost(let currentPost):
            let postViewController = PostViewController()
            postViewController.post = currentPost
            postViewController.coordinatorDeligate = self
            navigationController?.pushViewController(postViewController, animated: true)

        }
    
    }
}

