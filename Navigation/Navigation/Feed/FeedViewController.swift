import UIKit

class FeedViewController: UIViewController {
    
    var currentPost: Post?
    let button1 = UIButton()
    let button2 = UIButton()
    let buttonsSteckView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Feed"

        //button1.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button1.setTitle("Go Post View 1", for: .normal)
        button1.backgroundColor = .lightGray
        button1.setTitleColor(.white, for: .normal)
        button1.layer.cornerRadius = 4
        button1.layer.masksToBounds = false
        button1.layer.shadowOffset = CGSize(width: 4, height: 4)
        button1.layer.shadowRadius = CGFloat(4)
        button1.layer.shadowColor = UIColor.black.cgColor
        button1.layer.shadowOpacity = 0.7
        button1.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        
        //button2.frame  = CGRect(x: 0, y: 0, width: 200, height: 50)
        button2.setTitle("Go Post View 2", for: .normal)
        button2.backgroundColor = .lightGray
        button2.setTitleColor(.white, for: .normal)
        button2.layer.cornerRadius = 4
        button2.layer.masksToBounds = false
        button2.layer.shadowOffset = CGSize(width: 4, height: 4)
        button2.layer.shadowRadius = CGFloat(4)
        button2.layer.shadowColor = UIColor.black.cgColor
        button2.layer.shadowOpacity = 0.7
        button2.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        
        buttonsSteckView.addArrangedSubview(button1)
        buttonsSteckView.addArrangedSubview(button2) 
        buttonsSteckView.frame = CGRect(x: 50, y: 50, width: 400, height: 100)
        buttonsSteckView.axis = .vertical
        buttonsSteckView.spacing = 10
        buttonsSteckView.distribution = .fillEqually
       
        self.view.addSubview(buttonsSteckView)
        
        buttonsSteckView.translatesAutoresizingMaskIntoConstraints = false
        [
            buttonsSteckView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            buttonsSteckView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonsSteckView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6, constant: 0),
            buttonsSteckView.heightAnchor.constraint(equalToConstant: 90)
        ].forEach({$0.isActive = true})
        
    }
         
    @objc func showPost() {
        currentPost = Post(title: "Post 12345", author: "?", description: "?", image: "?", likes: 0, views: 0)
        let postViewController = PostViewController()
        postViewController.post = currentPost
        navigationController?.pushViewController(postViewController, animated: true)

    }

}
