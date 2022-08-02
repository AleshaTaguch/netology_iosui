import UIKit
import SnapKit

protocol FeedViewDeligateProtocol: AnyObject {
    var viewModel: FeedViewModel {get set}
}

class FeedView: UIView {
    
   weak var deligate: FeedViewDeligateProtocol?
    
    private let textLabel: CustomLabel = {
        let textLabel = CustomLabel(defaultTextColor: .gray)
        return textLabel
    }()
    
    
    private lazy var textField: CustomTextField = CustomTextField(frame: .zero, placeholder: "Введете слово \(Constants.Users.userReleace.profile.name)") {
         self.textLabel.status = .unknown
         self.textLabel.text = nil
    }
    
    private lazy var button: CustomButton = CustomButton(frame: .zero, title: "Проверь текст") { self.tapButton() }

    
    init(deligate: FeedViewDeligateProtocol?) {
        super.init(frame: .zero)
        self.deligate = deligate
        if let valueDeligate = deligate {
            valueDeligate.viewModel.onEventCheckWord = { [weak self] (isValid, resultText) in
                guard let self = self else {return}
                if isValid {
                    self.textLabel.status = .isValid
                } else {
                    self.textLabel.status = .isInvalid
                }
                self.textLabel.text = resultText
                
            }
        }
        
        self.addSubviews(textLabel,textField,button)
        
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension FeedView {
    
    private func tapButton() {
        guard let valueText = textField.text else { return }
        guard let valueDeligate = deligate else { return }

        valueDeligate.viewModel.doEventAction(type: .checkWord(valueText))

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
