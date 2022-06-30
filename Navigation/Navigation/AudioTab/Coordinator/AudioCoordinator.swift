import Foundation
import UIKit

final class AudioCoordinator: AudioCoordinatorProtocol {
    weak var navigationController: UINavigationController?
    
    init(controller: UINavigationController?) {
        self.navigationController = controller
    }
    
    func start() {
        let audioViewController = AudioViewController()
        
        navigationController?.setViewControllers([audioViewController], animated: true)
    }

}
