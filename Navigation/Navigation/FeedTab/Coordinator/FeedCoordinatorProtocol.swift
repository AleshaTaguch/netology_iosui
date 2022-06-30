import Foundation
import UIKit
import StorageService

enum EventFeed {
    case showPost(Post)
    case showInfo
}

protocol FeedCoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController? {get set}
    func start()
    func doEventHandle(with typeEvent: EventFeed)
}

