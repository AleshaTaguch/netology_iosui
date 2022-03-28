import UIKit

class ProfileViewController: UIViewController {
    
    var isNeedShowLoginView: Bool = true

    let profileTableHeaderView: ProfileTableHeaderView = {
        let profileTableHeaderView = ProfileTableHeaderView()
        profileTableHeaderView.toAutoLayout()
        return profileTableHeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemGray6
        self.title = "Profile"
        
        self.view.addSubviews(profileTableHeaderView)
        activateConstraints()
        
        isNeedShowLoginView = true
        
    }
       
    override func viewDidAppear (_ animated: Bool) {
        super.viewDidAppear(animated)

        if isNeedShowLoginView {
            navigationController?.navigationBar.isHidden = true
            navigationController?.pushViewController(LoginViewController(), animated: animated)
            isNeedShowLoginView = false
        }
    
    }
    
}

extension ProfileViewController {
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            profileTableHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            profileTableHeaderView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            profileTableHeaderView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            profileTableHeaderView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}


