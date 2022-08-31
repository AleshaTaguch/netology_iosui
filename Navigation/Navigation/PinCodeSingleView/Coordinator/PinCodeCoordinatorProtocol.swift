import Foundation
import UIKit

protocol PinCodeCoordinatorProtocol: AnyObject {
    var navigationController: UIViewController? {get set}
    func start(mode: PinCodeViewMode, complition: @escaping (()->Void)) 
}
