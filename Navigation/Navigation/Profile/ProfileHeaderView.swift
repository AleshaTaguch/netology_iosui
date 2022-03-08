import UIKit

class ProfileHeaderView: UIView {
    
    let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.image = UIImage(named: "UserImage")
        avatarImageView.layer.cornerRadius = 65
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.toAutoLayout()
        return avatarImageView
    }()
    
    
    let fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = "Arthur Fellig (Weegee)"
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        fullNameLabel.toAutoLayout()
        return fullNameLabel
    }()
    
    let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Waiting for something"
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textColor = .gray
        statusLabel.toAutoLayout()
        return statusLabel
    }()
     
    let statusTextField: UITextField = {
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
    
    let setStatusButton: UIButton = {
        let setStatusButton = UIButton()
        setStatusButton.frame = CGRect(x: 16, y: 200, width: 350, height: 50)
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
    
    private var statusText: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
   
        self.backgroundColor = .systemGray6
        self.addSubviews(avatarImageView,setStatusButton,fullNameLabel,statusLabel,statusTextField)

        activateConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ProfileHeaderView {
    
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
    
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 130),
            avatarImageView.heightAnchor.constraint(equalToConstant: 130),
            
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            setStatusButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            setStatusButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
                        
            fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            fullNameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
            fullNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -34 - 16),
            statusLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
            statusLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            statusLabel.heightAnchor.constraint(equalToConstant: 20),
            
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 3),
            statusTextField.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
            statusTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}
