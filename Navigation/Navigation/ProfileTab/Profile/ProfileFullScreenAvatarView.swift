//
//  AvatarView.swift
//  Navigation
//
//  Created by tertyshniy on 24.03.2022.
//

import UIKit
import SnapKit

class ProfileFullScreenAvatarView: UIView {
    
    static let tapShowAvatar: String = "tapShowAvatar"
    static let tapHiddenAvatar: String = "tapHiddenAvatar"
    
    let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.image = UIImage(named: "UserImage")
        avatarImageView.layer.cornerRadius = Constants.ProfileView.AvatarImage.size / 2
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.toAutoLayout()
        return avatarImageView
    }()

    
    let closeImage: UIImageView = {
        let closeImage = UIImageView()
        closeImage.image = UIImage(systemName: "multiply.circle")
        closeImage.tintColor = .gray
        closeImage.alpha = 0
        closeImage.toAutoLayout()
        return closeImage
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0.7)
        self.addSubviews(avatarImageView,closeImage)
        
        activateConstraints()
        
        //тап для сворачивания аватара, который был открты на весь экран
        let tapCloseImageGestureRecognizer = UITapGestureRecognizer()
        tapCloseImageGestureRecognizer.addTarget(self, action: #selector( tapedCloseImage(_ :) ))
        closeImage.isUserInteractionEnabled = true
        closeImage.addGestureRecognizer(tapCloseImageGestureRecognizer)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
}

extension ProfileFullScreenAvatarView {
    @objc func tapedCloseImage(_ recognizer: UITapGestureRecognizer) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: Notification.Name(ProfileFullScreenAvatarView.tapHiddenAvatar), object: nil)
    }

}

extension ProfileFullScreenAvatarView {
    
    private func activateConstraints() {
  
        avatarImageView.snp.makeConstraints {make in
            make.center.equalToSuperview()
            make.width.equalTo(self.snp.width).inset(Constants.ProfileView.AvatarImage.leftMargin)
            make.height.equalTo(self.snp.width).inset(Constants.ProfileView.AvatarImage.topMargin)
        }
        
        closeImage.snp.makeConstraints {make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(Constants.ProfileView.AvatarImage.topMargin)
            make.trailing.equalToSuperview().inset(Constants.ProfileView.AvatarImage.leftMargin)
            make.width.equalTo(self.snp.width).multipliedBy(0.1)
            make.height.equalTo(self.snp.width).multipliedBy(0.1)
        }
        
    }
}

