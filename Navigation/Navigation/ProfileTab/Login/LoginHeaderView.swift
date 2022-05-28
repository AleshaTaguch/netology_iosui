import UIKit

protocol LoginHeaderViewDeligateProtocol: AnyObject {
    func tapLoginButton(login: String, password: String)
}

class LoginHeaderView: UIView {
    
    private weak var delegate: LoginHeaderViewDeligateProtocol?
    
    private let logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: Constants.LoginView.Logo.imageName)
        logoImageView.toAutoLayout()
        return logoImageView
    }()
    
    private let loginTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.font = UIFont.systemFont(ofSize: Constants.LoginView.TextField.fontSize, weight: .regular)
        loginTextField.backgroundColor = .systemGray6
        loginTextField.textColor = .black
        loginTextField.tintColor = UIColor(named: "accentColor")
        loginTextField.placeholder = Constants.LoginView.TextField.loginPlaceholderText
        loginTextField.layer.borderWidth = Constants.LoginView.TextField.borderWidth
        loginTextField.layer.borderColor = UIColor.lightGray.cgColor
        loginTextField.setLeftRigthTextMargin()
        loginTextField.toAutoLayout()
        return loginTextField
    }()

    private let pwdTextField: UITextField = {
        let pwdTextField = UITextField()
        pwdTextField.font = UIFont.systemFont(ofSize: Constants.LoginView.TextField.fontSize, weight: .regular)
        pwdTextField.backgroundColor = .systemGray6
        pwdTextField.textColor = .black
        pwdTextField.tintColor = UIColor(named: "accentColor")
        pwdTextField.autocapitalizationType = .none
        pwdTextField.placeholder = Constants.LoginView.TextField.pwdPlaceholderText
        pwdTextField.layer.borderWidth = Constants.LoginView.TextField.borderWidth
        pwdTextField.layer.borderColor = UIColor.lightGray.cgColor
        pwdTextField.isSecureTextEntry = true
        pwdTextField.setLeftRigthTextMargin()
        pwdTextField.toAutoLayout()
        return pwdTextField
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = Constants.LoginView.StackField.cornerRadius
        stackView.layer.masksToBounds = true
        stackView.layer.borderWidth = Constants.LoginView.StackField.borderWidth
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.clipsToBounds = true
        stackView.toAutoLayout()
        return stackView
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.layer.cornerRadius = Constants.LoginView.LoginButton.cornerRadius
        loginButton.layer.masksToBounds = true
        if let pixel = UIImage(named: Constants.LoginView.LoginButton.backgraundImageName) {
            loginButton.setBackgroundImage(pixel.alpha(1), for: .normal)
            loginButton.setBackgroundImage(pixel.alpha(0.8), for: .selected)
            loginButton.setBackgroundImage(pixel.alpha(0.8), for: .highlighted)
            loginButton.setBackgroundImage(pixel.alpha(0.8), for: .disabled)
        } else {
            loginButton.backgroundColor = .darkGray
        }
        loginButton.setTitle(Constants.LoginView.LoginButton.titleText, for: .normal)
        loginButton.titleLabel?.font =  UIFont.systemFont(ofSize: Constants.LoginView.LoginButton.fontSize)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        loginButton.toAutoLayout()
        return loginButton
    }()
    
    private lazy var pickPasswordButton: UIButton = {
        let pickPasswordButton = UIButton()
        pickPasswordButton.layer.cornerRadius = Constants.LoginView.LoginButton.cornerRadius
        pickPasswordButton.layer.masksToBounds = true
        pickPasswordButton.backgroundColor = .lightGray
        
        pickPasswordButton.setTitle("Pick a password", for: .normal)
        pickPasswordButton.titleLabel?.font =  UIFont.systemFont(ofSize: Constants.LoginView.LoginButton.fontSize)
        pickPasswordButton.setTitleColor(.white, for: .normal)
        pickPasswordButton.addTarget(self, action: #selector(tapPickPasswordButton), for: .touchUpInside)
        pickPasswordButton.toAutoLayout()
        return pickPasswordButton
    }()
    
    
 
    init(deligate: LoginHeaderViewDeligateProtocol?) {
        self.delegate = deligate
        super.init(frame: .zero)
        
        self.backgroundColor = .white
                
        stackView.addArrangedSubviews(loginTextField, pwdTextField)
        self.addSubviews(logoImageView, stackView, loginButton, pickPasswordButton)
        activateConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension LoginHeaderView {
    
    @objc func tapLoginButton() {
        
        guard let currentUserName = loginTextField.text else { return }
        guard let currentUserPwd = pwdTextField.text else { return }
        
        if let valueDelegate = delegate {
            valueDelegate.tapLoginButton(login: currentUserName, password: currentUserPwd)
        }
    }
    
    @objc func tapPickPasswordButton() {
        let lengthPassword: Int = 3
        let rigthPassword: String = PasswordCreator().randomPassword(length: lengthPassword)
        print("rigthPassword = \(rigthPassword)")

        let creckPassword = PasswordCreator().bruteForcePassword(length: lengthPassword) { word in
            return word == rigthPassword
        }

        if let valueCreckPassword = creckPassword {
            print("creckPassword = \(valueCreckPassword)")
        } else {
            print("не получилось")
        }
        
    }
    
    
}

// MARK: extension

extension LoginHeaderView {
    
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.LoginView.Logo.topMargin),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.LoginView.Logo.width),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.LoginView.Logo.height),
         
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Constants.LoginView.StackField.topMargin),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.LoginView.StackField.leftMargin),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.LoginView.StackField.rigthMargin),
            stackView.heightAnchor.constraint(equalToConstant: Constants.LoginView.StackField.height),
            
            loginTextField.heightAnchor.constraint(equalToConstant: Constants.LoginView.TextField.height),
            pwdTextField.heightAnchor.constraint(equalToConstant: Constants.LoginView.TextField.height),
            
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Constants.LoginView.LoginButton.topMargin),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.LoginView.LoginButton.leftMargin),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.LoginView.LoginButton.leftMargin),
            loginButton.heightAnchor.constraint(equalToConstant: Constants.LoginView.LoginButton.height),
            //loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            pickPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: Constants.LoginView.LoginButton.topMargin),
            pickPasswordButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.LoginView.LoginButton.leftMargin),
            pickPasswordButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.LoginView.LoginButton.leftMargin),
            pickPasswordButton.heightAnchor.constraint(equalToConstant: Constants.LoginView.LoginButton.height),
            pickPasswordButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
