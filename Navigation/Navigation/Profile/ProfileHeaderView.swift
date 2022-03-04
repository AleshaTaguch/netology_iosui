//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Убрир on 20.02.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let avatarImageView: UIImageView
    let fullNameLabel: UILabel
    let statusLabel: UILabel
    let statusTextField: UITextField
    let setStatusButton: UIButton
    
    private var statusText: String?
    
    override init(frame: CGRect) {
        
        avatarImageView = UIImageView()
        fullNameLabel = UILabel()
        statusLabel = UILabel()
        statusTextField = UITextField()
        setStatusButton = UIButton()
        
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        avatarImageView.image = UIImage(named: "UserImage")
        avatarImageView.frame = CGRect(x: 16, y: 56, width: 130, height: 130)
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.contentMode = .scaleAspectFill
        addSubview(avatarImageView)
        
        setStatusButton.frame = CGRect(x: 16, y: 200, width: 350, height: 50)
        setStatusButton.setTitle("Show status", for: .normal)
        setStatusButton.backgroundColor = UIColor(red:0x00/255.0, green: 122.0/255.0, blue: 0xFF/255.0, alpha: 1)
        setStatusButton.setTitleColor(.white, for: .normal)
        setStatusButton.layer.cornerRadius = 4
        setStatusButton.layer.masksToBounds = false
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowRadius = CGFloat(4)
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowOpacity = 0.7
        setStatusButton.addTarget(self, action: #selector(setStatusButtonPressed), for: .touchUpInside)
        self.addSubview(setStatusButton)
        
        fullNameLabel.frame = CGRect(x: avatarImageView.frame.origin.x * 2 + avatarImageView.frame.size.width,
                                     y: 100,
                                     width: 200,
                                     height: 20)
        fullNameLabel.text = "Очень Добрый Кот"
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        self.addSubview(fullNameLabel)
        

        statusLabel.frame = CGRect(x: avatarImageView.frame.origin.x * 2 + avatarImageView.frame.size.width,
                                   y: setStatusButton.frame.origin.y - 34 - 20,
                                   width: 200,
                                   height: 20)
        statusLabel.text = "Waiting for something"
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textColor = .gray
        //statusLabel.backgroundColor = .cyan
           
        self.addSubview(statusLabel)
        
        statusTextField.frame = CGRect(x: 16, y: 400, width: 350, height: 40)
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.masksToBounds = true
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.backgroundColor = .white
        statusTextField.font = UIFont.systemFont(ofSize: 15)
        statusTextField.textColor = .black
        statusTextField.addTarget(self, action:  #selector(statusTextChanged), for: .editingChanged)
        statusTextField.placeholder = "Введите новый статус"
        self.addSubview(statusTextField)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    override func layoutSubviews() {
        super.layoutSubviews()

        if let superView = superview {
            avatarImageView.frame.origin.x = superView.safeAreaLayoutGuide.layoutFrame.origin.x + 16
            avatarImageView.frame.origin.y = superView.safeAreaLayoutGuide.layoutFrame.origin.y + 16
            let sizeAvatar = (min(self.frame.size.width, self.frame.size.height)  / 3) - 16
            avatarImageView.frame.size.width = sizeAvatar
            avatarImageView.frame.size.height = sizeAvatar
            avatarImageView.layer.cornerRadius = sizeAvatar / 2
           
            setStatusButton.frame.origin.x = superView.safeAreaLayoutGuide.layoutFrame.origin.x + 16
            setStatusButton.frame.origin.y = avatarImageView.frame.origin.y + avatarImageView.frame.height + 16
            setStatusButton.frame.size.width = superView.safeAreaLayoutGuide.layoutFrame.width - 32
            
            fullNameLabel.frame.origin.x = avatarImageView.frame.origin.x +
                                           avatarImageView.frame.size.width + 16
            fullNameLabel.frame.origin.y = superView.safeAreaLayoutGuide.layoutFrame.origin.y + 27
            fullNameLabel.frame.size.width = superView.safeAreaLayoutGuide.layoutFrame.width -
                (fullNameLabel.frame.origin.x - superView.safeAreaLayoutGuide.layoutFrame.origin.x) - 16
            
            statusLabel.frame.origin.x = fullNameLabel.frame.origin.x
            statusLabel.frame.origin.y = setStatusButton.frame.origin.y - 34 - statusLabel.frame.size.height
            statusLabel.frame.size.width = superView.safeAreaLayoutGuide.layoutFrame.width -
                (statusLabel.frame.origin.x - superView.safeAreaLayoutGuide.layoutFrame.origin.x) - 16
            
            //  Внимание !!
            //  Изменение размещение элементов для задачи со звездочнкой
            
            statusTextField.frame.origin.x = statusLabel.frame.origin.x
            statusTextField.frame.origin.y = statusLabel.frame.origin.y + statusLabel.frame.size.height + 16
            statusTextField.frame.size.width = statusLabel.frame.size.width
            
            setStatusButton.frame.origin.y = statusTextField.frame.origin.y +
                                             statusTextField.frame.size.height + 16
        }
            

    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
