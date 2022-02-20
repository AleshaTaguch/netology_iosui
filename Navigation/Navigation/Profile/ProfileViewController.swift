import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .lightGray
        self.title = "Profile"
        
        let profileHView = ProfileHeaderView()
        profileHView.backgroundColor = color1
        self.view.addSubview(profileHView)
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //let myViews = view.subviews.filter{$0 is ProfileHeaderView}
        let myViews = view.subviews.first{$0 is ProfileHeaderView}
        myViews?.frame = self.view.frame
        //self.view.subviews.first().frame = self.view.frame
    }
    
}

