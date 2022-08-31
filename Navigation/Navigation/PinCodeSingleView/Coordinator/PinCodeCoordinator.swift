import Foundation
import UIKit

final class PinCodeCoordinator: PinCodeCoordinatorProtocol {
    weak var navigationController: UIViewController?
    
    init(controller: UIViewController?) {
        self.navigationController = controller
    }
    
    func start(mode: PinCodeViewMode, complition: @escaping (()->Void)) {
        let pinCodeViewController = PinCodeViewController(mode: mode) { /* [weak self] in
            guard let self = self else {return}*/
            self.navigationController?.dismiss(animated: true, completion: nil)
            complition()
        }
        navigationController?.present(pinCodeViewController, animated: true, completion: nil)
    }

}
