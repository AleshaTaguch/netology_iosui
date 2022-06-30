import Foundation
import UIKit

final class VideoCoordinator: VideoCoordinatorProtocol {
    weak var navigationController: UINavigationController?
    
    init(controller: UINavigationController?) {
        self.navigationController = controller
    }
    
    func start() {
        let videoViewController = VideoViewController()
        
        navigationController?.setViewControllers([videoViewController], animated: true)
    }

}
