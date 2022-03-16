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
        
        // подписаться на уведомления
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(showViewCollection), name: NSNotification.Name(PhotoTableViewCell.tapNotificationName), object: nil)

    }
       
    override func viewDidAppear (_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        if isNeedShowLoginView {
            navigationController?.pushViewController( LoginViewController(), animated: animated)
            isNeedShowLoginView = false
        }
        
    }    
    
    @objc private func showViewCollection(notification: NSNotification) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.pushViewController(PhotosViewController(), animated: true)
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


