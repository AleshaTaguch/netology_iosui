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
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        activityIndicator.color = .gray
        activityIndicator.toAutoLayout()
        return activityIndicator
    }()
    
 
    init(deligate: LoginHeaderViewDeligateProtocol?) {
        self.delegate = deligate
        super.init(frame: .zero)
        
        self.backgroundColor = .white
                
        stackView.addArrangedSubviews(loginTextField, pwdTextField)
        self.addSubviews(logoImageView,
                         stackView,
                         loginButton,
                         pickPasswordButton,
                         activityIndicator)
        activateConstraints()
        //activityIndicator.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        
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
        
        let lengthPassword: Int = 5
        let rigthPassword: String = PasswordCreator().randomPassword(length: lengthPassword)
        
        pwdTextField.text = nil
        pwdTextField.placeholder = "crack password: \(rigthPassword)"
        
        activityIndicator.startAnimating()
        
        //Вариант реализации через DispatchWorkItem + Result. Тоже работает
        
        let queue = DispatchQueue(label: "crackPasswordQueue")
        let crackPasswordWorkItem = DispatchWorkItem {
            print("Запуск crackPasswordWorkItem ",Thread.current)
            PasswordCreator().bruteForcePassword(length: lengthPassword,
                                                 cheker: { word in return word == rigthPassword}) { [weak self] result in
                var resultString: String = ""
                print("запуск outputResultWorkItem ",Thread.current)
                switch result {
                case .success(let crackPassword):
                    resultString = crackPassword
                case .failure(let error):
                    switch error as? PasswordCreatorError {
                    case .failed(let errorDescription):
                        resultString = errorDescription
                    case .randomErrorTry:
                        resultString = "Случайная попытка с ошибкой"
                    case .none:
                        resultString = "unknow eror"
                    }
                }
                
                DispatchQueue.main.async {
                    self?.pwdTextField.isSecureTextEntry = false
                    self?.pwdTextField.text = resultString
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        queue.async(execute: crackPasswordWorkItem)
        
        /*
        //Вариант реализации через DispatchWorkItem. Тоже работает
        
        var crackPassword: String?
        
        let queue = DispatchQueue(label: "crackPasswordQueue")
        
        let crackPasswordWorkItem = DispatchWorkItem {
            print("Запуск crackPasswordWorkItem ",Thread.current)
            crackPassword = PasswordCreator().bruteForcePassword(length: lengthPassword) { word in
                return word == rigthPassword
            }
        }
        
        let outputResultWorkItem = DispatchWorkItem {
            print("запуск outputResultWorkItem ",Thread.current)
            self.pwdTextField.isSecureTextEntry = false
            if let valueCrackPassword = crackPassword {
                self.pwdTextField.text = valueCrackPassword
            } else {
                self.pwdTextField.text = "не получилось подобрать"
            }
            self.activityIndicator.stopAnimating()
        }
        
        crackPasswordWorkItem.notify(queue: .main, execute: outputResultWorkItem)
        queue.async(execute: crackPasswordWorkItem)
        
        */

        /*
        // Вариант через DispatchQueue. Работает. Оставил для примера.
        DispatchQueue.global().async {
            let crackPassword = PasswordCreator().bruteForcePassword(length: lengthPassword) { word in
                return word == rigthPassword
            }
            DispatchQueue.main.async {
                self.pwdTextField.isSecureTextEntry = false
                if let valueCrackPassword = crackPassword {
                    print("crackPassword = \(valueCrackPassword)")
                    self.pwdTextField.text = valueCrackPassword
                } else {
                    print("не получилось")
                    self.pwdTextField.text = "не получилось"
                }
                self.activityIndicator.stopAnimating()
            }
        }
        */
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
            pickPasswordButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: pwdTextField.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: pwdTextField.centerYAnchor)

        ])
    }
}
