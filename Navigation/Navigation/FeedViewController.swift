import UIKit

class FeedViewController: UIViewController {
    
    var currentPost: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .cyan
        self.title = "Feed"
        
        let button = UIButton(frame: CGRect(x: 50, y: 100, width: 200, height: 50))
        button.setTitle("Go Post View", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        self.view.addSubview(button)
    }
         
    @objc func showPost() {
        currentPost = Post(title: "Post 12345")
        let postViewController = PostViewController()
        postViewController.post = currentPost
        navigationController?.pushViewController(postViewController, animated: true)

    }

}
