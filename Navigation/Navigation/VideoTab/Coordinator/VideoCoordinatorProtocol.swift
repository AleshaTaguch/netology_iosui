import Foundation
import UIKit

protocol VideoCoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController? {get set}
    func start()
}

