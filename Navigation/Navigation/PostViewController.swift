import UIKit

class PostViewController: UIViewController {
    
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        if let titleText = post?.title  {
            self.title = titleText
        } else {
            self.title = "[PostView]"
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain ,target: self, action: #selector(showInfo))
                    
    }
    
    @objc func showInfo () {
        let infoViewController = InfoViewController()
        present(infoViewController, animated: false, completion: nil)
    }
    
    
}
