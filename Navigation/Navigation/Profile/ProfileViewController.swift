import UIKit

class ProfileViewController: UIViewController {
    
    var isShowLoginView: Bool = false
    
    let profileHeaderView: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView()
        profileHeaderView.toAutoLayout()
        return profileHeaderView
    }()
    
    let newButtonAtTheBottom: UIButton = {
        let newButtonAtTheBottom  = UIButton()
        newButtonAtTheBottom.setTitle("New Button At The Bottom", for: .normal)
        newButtonAtTheBottom.backgroundColor = UIColor(red:0x00/255.0, green: 122.0/255.0, blue: 0xFF/255.0, alpha: 1)
        newButtonAtTheBottom.setTitleColor(.white, for: .normal)
        newButtonAtTheBottom.layer.cornerRadius = 4
        newButtonAtTheBottom.layer.masksToBounds = false
        newButtonAtTheBottom.layer.shadowOffset = CGSize(width: 4, height: 4)
        newButtonAtTheBottom.layer.shadowRadius = CGFloat(4)
        newButtonAtTheBottom.layer.shadowColor = UIColor.black.cgColor
        newButtonAtTheBottom.layer.shadowOpacity = 0.7
        newButtonAtTheBottom.toAutoLayout()
        return newButtonAtTheBottom
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .lightGray
        self.title = "Profile"
        
        self.view.addSubviews(profileHeaderView,newButtonAtTheBottom)
        activateConstraints()
        
        isShowLoginView = true
        
    }
    
    override func viewDidAppear (_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isShowLoginView {
            navigationController?.navigationBar.isHidden = true
            navigationController?.pushViewController(LoginViewController(), animated: animated)
            isShowLoginView = !isShowLoginView
        }
        
    }
   
}

extension ProfileViewController {
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            newButtonAtTheBottom.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            newButtonAtTheBottom.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            newButtonAtTheBottom.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            newButtonAtTheBottom.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


