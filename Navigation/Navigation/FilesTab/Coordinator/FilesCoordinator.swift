import Foundation
import UIKit

final class FilesCoordinator: FilesCoordinatorProtocol {
    weak var navigationController: UINavigationController?
    
    init(controller: UINavigationController?) {
        self.navigationController = controller
    }
    
    func start() {
        let dirDocumentsViewController = DirDocumentsViewController()
        dirDocumentsViewController.coordinatorDeligate = self
        navigationController?.setViewControllers([dirDocumentsViewController], animated: true)
    }
    
    func doEventHandle(with typeEvent: EventFeed) {
        /*
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
            
        case .showDirDocuments:
            let dirDocumentsViewController = DirDocumentsViewController()
            dirDocumentsViewController.coordinatorDeligate = self
            navigationController?.pushViewController(dirDocumentsViewController, animated: true)

        }
        */
    }
}

