import Foundation
import UIKit

enum EventFiles {
    case showPost
    case showInfo
    case showDirDocuments
}

protocol FilesCoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController? {get set}
    func start()
    func doEventHandle(with typeEvent: EventFeed)
}

