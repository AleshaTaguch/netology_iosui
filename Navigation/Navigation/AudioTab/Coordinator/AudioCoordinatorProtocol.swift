import Foundation
import UIKit

protocol AudioCoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController? {get set}
    func start()
}
