import Foundation
import UIKit

protocol AppCoordinatorProtocol: AnyObject {
    var appTabBarControler: UITabBarController? {get set}
    func startApplication()
}
