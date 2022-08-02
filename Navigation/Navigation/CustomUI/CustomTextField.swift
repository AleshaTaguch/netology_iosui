import UIKit

class CustomTextField: UITextField {
    
    var actionEditingTextField: (() -> Void)?
    
    init(frame: CGRect, placeholder: String?, actionEditingTextField: (() -> Void)?) {
        super.init(frame: frame)
        self.actionEditingTextField = actionEditingTextField
        
        self.font = UIFont.systemFont(ofSize: Constants.LoginView.TextField.fontSize, weight: .regular)
        self.backgroundColor = .systemGray6
        self.textColor = .black
        self.tintColor = UIColor(named: "accentColor")
        self.placeholder = "Введете слово \(Constants.Users.userReleace.profile.name)"
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.setLeftRigthTextMargin()
        self.addTarget(self, action:  #selector(editTextFiedl), for: .editingChanged)
        self.toAutoLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomTextField {
    
    @objc func editTextFiedl(_ textField: UITextField) {
        if let valueActionEditingTextField = actionEditingTextField {
            valueActionEditingTextField()
        }
    }
}
