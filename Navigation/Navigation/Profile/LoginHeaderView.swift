import UIKit

class LoginHeaderView: UIView {
    
    let logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: Constants.LoginView.Logo.imageName)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    let loginTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.font = UIFont.systemFont(ofSize: Constants.LoginView.TextField.fontSize, weight: .regular)
        loginTextField.backgroundColor = .systemGray6
        loginTextField.textColor = .black
        loginTextField.tintColor = UIColor(named: "accentColor")
        loginTextField.placeholder = Constants.LoginView.TextField.loginPlaceholderText
        loginTextField.layer.borderWidth = Constants.LoginView.TextField.borderWidth
        loginTextField.layer.borderColor = UIColor.lightGray.cgColor
        loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.BlankView.width, height: Constants.BlankView.height))
        loginTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.BlankView.width, height: Constants.BlankView.height))
        loginTextField.leftViewMode = .always
        loginTextField.rightViewMode = .always
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        return loginTextField
    }()

    let pwdTextField: UITextField = {
        let pwdTextField = UITextField()
        pwdTextField.font = UIFont.systemFont(ofSize: Constants.LoginView.TextField.fontSize, weight: .regular)
        pwdTextField.backgroundColor = .systemGray6
        pwdTextField.textColor = .black
        pwdTextField.tintColor = UIColor(named: "accentColor")
        pwdTextField.autocapitalizationType = .none
        pwdTextField.placeholder = Constants.LoginView.TextField.pwdPlaceholderText
        pwdTextField.layer.borderWidth = Constants.LoginView.TextField.borderWidth
        pwdTextField.layer.borderColor = UIColor.lightGray.cgColor
        pwdTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.BlankView.width, height: Constants.BlankView.height))
        pwdTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.BlankView.width, height: Constants.BlankView.height))
        pwdTextField.leftViewMode = .always
        pwdTextField.rightViewMode = .always
        pwdTextField.isSecureTextEntry = true
        pwdTextField.translatesAutoresizingMaskIntoConstraints = false
        return pwdTextField
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = Constants.LoginView.StackField.cornerRadius
        stackView.layer.masksToBounds = true
        stackView.layer.borderWidth = Constants.LoginView.StackField.borderWidth
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        return stackView
    }()
    
    let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        if let pixel = UIImage(named: "blue_pixel") {
            loginButton.setBackgroundImage(pixel.alpha(1), for: .normal)
            loginButton.setBackgroundImage(pixel.alpha(0.8), for: .selected)
            loginButton.setBackgroundImage(pixel.alpha(0.8), for: .highlighted)
            loginButton.setBackgroundImage(pixel.alpha(0.8), for: .disabled)
        } else {
            loginButton.backgroundColor = .darkGray
        }
        loginButton.setTitle("Log In", for: .normal)
        loginButton.titleLabel?.font =  UIFont.systemFont(ofSize: 18)
        loginButton.setTitleColor(.white, for: .normal)
        //loginButton.addTarget(self, action:  #selector(statusTextChanged), for: .editingChanged)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        stackView.addArrangedSubviews(loginTextField, pwdTextField)
        self.addSubviews(logoImageView, stackView, loginButton)
        activateConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

// MARK: Extensions

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
        
        loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
        loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        loginButton.heightAnchor.constraint(equalToConstant: 50),
        loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
        ])
    }
}
