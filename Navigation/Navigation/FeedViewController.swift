import UIKit

class FeedViewController: UIViewController {
    
    var currentPost: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        self.title = "Feed"
        
        let button = UIButton(frame: CGRect(x: 50, y: 100, width: 200, height: 50))
        button.setTitle("Go Post View", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = CGFloat(4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        self.view.addSubview(button)
    }
         
    @objc func showPost() {
        currentPost = Post(title: "Post 12345")
        let postViewController = PostViewController()
        postViewController.post = currentPost
        navigationController?.pushViewController(postViewController, animated: true)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let myButton = self.view.subviews.first{$0 is UIButton}
        myButton?.center = view.center

    }
    

}
