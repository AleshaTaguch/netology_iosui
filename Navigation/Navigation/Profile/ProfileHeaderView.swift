import UIKit
import SnapKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    static let classIdentifier: String = "ProfileHeaderView"
   
    private var statusText: String?
    
    let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.layer.cornerRadius = Constants.ProfileView.AvatarImage.size / 2
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.toAutoLayout()
        return avatarImageView
    }()
    
    let fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        fullNameLabel.toAutoLayout()
        return fullNameLabel
    }()
    
    let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textColor = .gray
        statusLabel.toAutoLayout()
        return statusLabel
    }()
     
    lazy var statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.masksToBounds = true
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.backgroundColor = .white
        statusTextField.font = UIFont.systemFont(ofSize: 15)
        statusTextField.textColor = .black
        statusTextField.placeholder = "Введите новый статус"
        statusTextField.setLeftRigthTextMargin()
        statusTextField.addTarget(self, action:  #selector(statusTextChanged), for: .editingChanged)
        statusTextField.toAutoLayout()
        return statusTextField
    }()
    
    lazy var setStatusButton: UIButton = {
        let setStatusButton = UIButton()
        setStatusButton.setTitle("Set status", for: .normal)
        setStatusButton.backgroundColor = UIColor(red:0x00/255.0, green: 122.0/255.0, blue: 0xFF/255.0, alpha: 1)
        setStatusButton.setTitleColor(.white, for: .normal)
        setStatusButton.layer.cornerRadius = 12
        setStatusButton.layer.masksToBounds = false
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowRadius = CGFloat(4)
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowOpacity = 0.7
        setStatusButton.addTarget(self, action: #selector(setStatusButtonPressed), for: .touchUpInside)
        setStatusButton.toAutoLayout()
        return setStatusButton
    }()
    
    lazy var fullScreenAvatarView: ProfileFullScreenAvatarView = {
        let fullScreenAvatarView = ProfileFullScreenAvatarView()
        fullScreenAvatarView.toAutoLayout()
        fullScreenAvatarView.isHidden = true
        return fullScreenAvatarView
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
   
        self.contentView.backgroundColor = .systemGray6
        self.contentView.addSubviews(avatarImageView,
                                     setStatusButton,
                                     fullNameLabel,
                                     statusLabel,
                                     statusTextField,
                                     fullScreenAvatarView)
        activateConstraints()
        
        // Регистрация нажатия на аватар для показа аватара на весь экран
        let tapAvatarGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapedAvatarImageView(_:)))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapAvatarGestureRecognizer)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ProfileHeaderView {
    
    @objc func tapedAvatarImageView(_ recognizer: UITapGestureRecognizer) {
        
        let userInfoNatification: [String : Any] = ["fullScreenAvatarView":fullScreenAvatarView]
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: Notification.Name(ProfileFullScreenAvatarView.tapShowAvatar),
                                object: nil,
                                userInfo: userInfoNatification)
    }
        
    @objc func setStatusButtonPressed() {
        var statusText: String
        if let status =  statusLabel.text {
            statusText = status
        } else {
            statusText = "пуст"
        }
        
        print("setStatusButtonPressed нажата, текущий статус \(statusText)")
        
        // Внимание !!
        // Смена статуста по задаче со звездочкой
        statusLabel.text = self.statusText
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        if let newStatusTest = textField.text {
            self.statusText = newStatusTest
            print("Введен новый статус = \(newStatusTest)")
        } else {
            self.statusText = nil
        }
    }
    
}

extension ProfileHeaderView {
    
    public func setProfileFromUser(_ user: User) {
        avatarImageView.image = user.avatarImage
        fullNameLabel.text = user.fullName
        statusLabel.text = user.status.rawValue
    }
}

extension ProfileHeaderView {
    
    private func activateConstraints () {
        
        avatarImageView.snp.makeConstraints {make in
            make.top.equalToSuperview().inset(Constants.ProfileView.AvatarImage.topMargin)
            make.left.equalToSuperview().inset(Constants.ProfileView.AvatarImage.leftMargin)
            make.width.height.equalTo(Constants.ProfileView.AvatarImage.size)
        }
        
        setStatusButton.snp.makeConstraints {make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(Constants.ProfileView.StatusButton.topMargin)
            make.left.equalToSuperview().inset(Constants.ProfileView.StatusButton.leftMargin)
            make.right.equalToSuperview().inset(Constants.ProfileView.StatusButton.rightMargin)
            make.height.equalTo(Constants.ProfileView.StatusButton.height)
            make.bottom.equalToSuperview().inset(Constants.ProfileView.StatusButton.buttomMargin)
        }
        
        fullNameLabel.snp.makeConstraints {make in
            make.top.equalToSuperview().inset(Constants.ProfileView.FullName.topMargin)
            make.left.equalTo(avatarImageView.snp.right).offset(Constants.ProfileView.FullName.leftMargin)
            make.right.equalToSuperview().inset(Constants.ProfileView.FullName.leftMargin)
            make.height.equalTo(Constants.ProfileView.FullName.height)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.bottom.equalTo(setStatusButton.snp.top).offset(-Constants.ProfileView.StatusLabel.buttomMargin)
            make.left.equalTo(avatarImageView.snp.right).offset(Constants.ProfileView.StatusLabel.leftMargin)
            make.right.equalToSuperview().inset(Constants.ProfileView.StatusLabel.rightMargin)
            make.height.equalTo(Constants.ProfileView.StatusLabel.height)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(Constants.ProfileView.StatusField.topMargin)
            make.left.equalTo(avatarImageView.snp.right).offset(Constants.ProfileView.StatusField.leftMargin)
            make.right.equalToSuperview().inset(Constants.ProfileView.StatusField.rightMargin)
            make.height.equalTo(Constants.ProfileView.StatusField.height)
        }

        fullScreenAvatarView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.height.width.equalTo(Constants.ProfileView.AvatarImage.size +
                                      Constants.ProfileView.AvatarImage.leftMargin * 2)
        }        
    }

}
