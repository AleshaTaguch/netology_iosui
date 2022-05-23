import UIKit
import StorageService

class PostViewController: UIViewController {
    
    weak var coordinatorDeligate: FeedCoordinatorProtocol?
    
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 195.0/255.0, green: 176.0/255.0, blue: 145.0/255.0, alpha: 1)
        if let titleText = post?.title  {
            self.title = titleText
        } else {
            self.title = "[PostView]"
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain ,target: self, action: #selector(showInfo))
                    
    }
    
    @objc func showInfo () {
        if let cordinator = coordinatorDeligate {
            cordinator.doEventHandle(with: .showInfo)
        }
    }
    
    
}
