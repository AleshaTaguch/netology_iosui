import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    lazy var profileTableHeaderView: ProfileTableHeaderView = {
        let profileTableHeaderView = ProfileTableHeaderView()
        profileTableHeaderView.toAutoLayout()
        profileTableHeaderView.userServiceDeligate = self
        return profileTableHeaderView
    }()
    
    var fullScreenAvatarView: ProfileFullScreenAvatarView?
    var fullScreenAvatarViewConstraints: [NSLayoutConstraint?] = []
    
    var userService: UserService
    var userName: String
    
    init(currentUser currentUserService: UserService, currentUserName: String) {
        self.userService = currentUserService
        self.userName = currentUserName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray6
        #if DEBUG
        self.view.backgroundColor = .red
        #endif

        self.view.addSubviews(profileTableHeaderView)
        activateConstraints()
        
        let notificationCenter = NotificationCenter.default
        // подписаться на уведомления для показа фото галереи
        notificationCenter.addObserver(self, selector: #selector(showPhotosViewCollection), name: NSNotification.Name(PhotoTableViewCell.tapNotificationName), object: nil)
        
        // подписаться на уведомления для показа аватар на весь экран
        notificationCenter.addObserver(self, selector: #selector(showAvatarView), name: NSNotification.Name(ProfileFullScreenAvatarView.tapShowAvatar), object: nil)
        
        // подписаться на уведомления для показа аватар на весь экран
        notificationCenter.addObserver(self, selector: #selector(hiddenAvatarView), name: NSNotification.Name(ProfileFullScreenAvatarView.tapHiddenAvatar), object: nil)
    }
       
    override func viewDidAppear (_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

extension ProfileViewController {
    
    @objc private func showPhotosViewCollection(notification: NSNotification) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.pushViewController(PhotosViewController(), animated: true)
    }
    
    @objc private func showAvatarView(notification: NSNotification) {
        print("showAvatarView.....")
        
        guard let userInfoView = notification.userInfo?["fullScreenAvatarView"] as? ProfileFullScreenAvatarView else {
           return
        }
        
        fullScreenAvatarView = userInfoView
        
        profileTableHeaderView.tableView.isScrollEnabled = false
        fullScreenAvatarView?.isHidden = false
        fullScreenAvatarView?.isUserInteractionEnabled = true
        fullScreenAvatarViewConstraints = [
            fullScreenAvatarView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            fullScreenAvatarView?.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            fullScreenAvatarView?.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            fullScreenAvatarView?.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)]
        
        NSLayoutConstraint.activate(fullScreenAvatarViewConstraints.compactMap({$0}))
        
        UIView.animate(withDuration: 0.5,
                       animations: {
            self.fullScreenAvatarView?.avatarImageView.layer.cornerRadius = 0
            self.view.layoutIfNeeded() },
                       completion: {_ in  UIView.animate(withDuration: 0.3)
                                                         {self.fullScreenAvatarView?.closeImage.alpha = 1 }
                                    } )
        
    }
    
    @objc private func hiddenAvatarView(notification: NSNotification) {
        print("hiddenAvatarView.....")
        UIView.animate(withDuration: 0.3,
                       animations: { self.fullScreenAvatarView?.closeImage.alpha = 0 },
                       completion: {_ in  UIView.animate(withDuration: 0.5,
                                                         animations: {NSLayoutConstraint.deactivate(self.fullScreenAvatarViewConstraints.compactMap({$0}))
                                                                      self.fullScreenAvatarView?.avatarImageView.layer.cornerRadius = Constants.ProfileView.AvatarImage.size / 2
                                                                      self.view.layoutIfNeeded()},
                                                         completion: { _ in self.fullScreenAvatarView?.isHidden = true
                           self.profileTableHeaderView.tableView.isScrollEnabled = true

                       })
                                    } )
    }
}

extension ProfileViewController {
    private func activateConstraints () {
        
        profileTableHeaderView.snp.makeConstraints {make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.bottom.equalTo(self.view)
        }
        
    }

}

extension ProfileViewController: UserServiceDeligate {
    func getUserObject() -> User? {
        return try? userService.getUserObjectbyName(userName)
    }
    
    
}
