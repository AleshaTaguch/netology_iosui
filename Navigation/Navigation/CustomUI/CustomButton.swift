import UIKit

class CustomButton: UIButton {
    
    var actionTapButton: (() -> Void)?
    
    init(frame: CGRect, title: String?,actionTapButton: (() -> Void)?) {
        super.init(frame: frame)
        
        self.actionTapButton = actionTapButton
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = CGFloat(4)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.7
        self.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        self.toAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomButton {
    @objc private func tapButton() {
        if let valueActionTapButton = self.actionTapButton {
            valueActionTapButton()
        }
    }
}
