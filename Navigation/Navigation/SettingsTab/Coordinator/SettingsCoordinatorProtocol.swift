import Foundation
import UIKit

enum EventSettings {
    case showPinCodeView
    case changeSortDirection
}

protocol SettingsCoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController? {get set}
    func start()
    func doEventHandle(with typeEvent: EventSettings)
}
