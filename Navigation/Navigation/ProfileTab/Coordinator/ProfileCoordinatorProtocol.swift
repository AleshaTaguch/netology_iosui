import Foundation
import UIKit

protocol ProfileCoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController? {get set}
    func start()
}

