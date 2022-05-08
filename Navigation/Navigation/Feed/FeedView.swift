import UIKit
import SnapKit

protocol FeedViewDeligate: AnyObject {
    func checkWord(word: String) -> (isValid: Bool, resultText: String)
}

class FeedView: UIView {
    
   weak var deligate: FeedViewDeligate?
    
    private let textLabel: CustomLabel = {
        let textLabel = CustomLabel(defaultTextColor: .gray)
        return textLabel
    }()
    
    
    private lazy var textField: CustomTextField = CustomTextField(frame: .zero, placeholder: "Введете слово \(Constants.Users.userReleace.name)") {
         self.textLabel.status = .unknown
         self.textLabel.text = nil
    }
    
    private lazy var button: CustomButton = CustomButton(frame: .zero, title: "Проверь текст") { self.tapButton() }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews(textLabel,textField,button)
        
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension FeedView {
    
    private func tapButton() {
        print("tap")
        
        guard let valueText = textField.text else { return }
        guard let valueDeligate = deligate else { return }
        
        let result = valueDeligate.checkWord(word: valueText)
        if result.isValid {
            textLabel.status = .isValid
        } else {
            textLabel.status = .isInvalid
        }
        textLabel.text = result.resultText
        
        return
    }

}


extension FeedView {
    private func activateConstraints () {
        textField.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalToSuperview()
        }
        textLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(textField.snp.bottom)
        }
        button.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(textLabel.snp.bottom).offset(5)
        }
        
    }
}
