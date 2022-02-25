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
        
        self.backgroundColor = .lightGray
        
        avatarImageView.image = UIImage(named: "UserImage")
        avatarImageView.frame = CGRect(x: 16, y: 16, width: 130, height: 130) //16-56
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
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
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(setStatusButton)
        
        fullNameLabel.frame = CGRect(x: avatarImageView.frame.origin.x * 2 + avatarImageView.frame.size.width,
                                     y: 100,
                                     width: 200,
                                     height: 20)
        fullNameLabel.text = "Очень Добрый Кот"
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(fullNameLabel)
        
        
        statusLabel.frame = CGRect(x: avatarImageView.frame.origin.x * 2 + avatarImageView.frame.size.width,
                                   y: setStatusButton.frame.origin.y - 34 - 20,
                                   width: 200,
                                   height: 20)
        statusLabel.text = "Waiting for something"
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textColor = .gray
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
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
        statusTextField.borderStyle = .bezel
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(statusTextField)
        
        // добавляем констренты
        avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16).isActive = true
        setStatusButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        setStatusButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        setStatusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27).isActive = true
        fullNameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16).isActive = true
        fullNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        fullNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -34 - 16).isActive = true
        statusLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16).isActive = true
        statusLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        statusLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 3).isActive = true
        statusTextField.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16).isActive = true
        statusTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        statusTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
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
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
