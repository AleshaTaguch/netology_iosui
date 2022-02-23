import UIKit

class ProfileViewController: UIViewController {
    
    let label2 = UILabel()
      
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .lightGray
        self.title = "Profile"
        
        let profileHView = ProfileHeaderView()
        self.view.addSubview(profileHView)
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let profHViews = view.subviews.first(where: {$0 is ProfileHeaderView}) as? ProfileHeaderView {
            profHViews.frame = self.view.frame
        }
 
    }
    
}

