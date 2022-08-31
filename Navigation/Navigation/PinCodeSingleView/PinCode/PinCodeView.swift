import UIKit

final class PinCodeView: UIView {
    
    private weak var delegate: PinCodeViewDelegateProtocol?
    
    public var stageEnter: PinCodeViewStageEnter {
        didSet {
            pinCodeButton.setTitle(stageEnter.rawValue, for: .normal)
            pinCodeTextField.text = ""
        }
    }
    
    private let pinCodeTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: Constants.LoginView.TextField.fontSize, weight: .regular)
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = Constants.LoginView.LoginButton.cornerRadius
        textField.layer.masksToBounds = true
        textField.textColor = .black
        textField.tintColor = UIColor(named: "accentColor")
        textField.placeholder = "Pin Code"
        textField.layer.borderWidth = Constants.LoginView.TextField.borderWidth
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.setLeftRigthTextMargin()
        textField.toAutoLayout()
        return textField
    }()
    
    private lazy var pinCodeButton: UIButton = {
        let pinCodeButton = UIButton()
        pinCodeButton.layer.cornerRadius = Constants.LoginView.LoginButton.cornerRadius
        pinCodeButton.layer.masksToBounds = true
        pinCodeButton.backgroundColor = .darkGray
        pinCodeButton.titleLabel?.font =  UIFont.systemFont(ofSize: Constants.LoginView.LoginButton.fontSize)
        pinCodeButton.setTitleColor(.white, for: .normal)
        pinCodeButton.addTarget(self, action: #selector(tapPinCodeButton), for: .touchUpInside)
        pinCodeButton.toAutoLayout()
        return pinCodeButton
    }()
 
    init(delegate: PinCodeViewDelegateProtocol?) {
        self.delegate = delegate
        self.stageEnter = .createPin
        super.init(frame: .zero)
        
        self.backgroundColor = .white
                
        self.addSubviews(pinCodeTextField,
                         pinCodeButton)
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func activateConstraints () {
        NSLayoutConstraint.activate([
            pinCodeTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            pinCodeTextField.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -32),
            pinCodeTextField.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: -30),
            pinCodeTextField.heightAnchor.constraint(equalToConstant: 50),
            
            pinCodeButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            pinCodeButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -32),
            pinCodeButton.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: 30),
            pinCodeButton.heightAnchor.constraint(equalToConstant: 50)
         
        ])
    }

    @objc func tapPinCodeButton() {
        guard let pinCodeText = pinCodeTextField.text else { return }
        if let valueDelegate = delegate {
            valueDelegate.doActionPinCode(stageEnter: self.stageEnter, pinCode: pinCodeText)
        }
    }
    
}
