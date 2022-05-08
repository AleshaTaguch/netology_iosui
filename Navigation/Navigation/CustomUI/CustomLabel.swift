import UIKit

class CustomLabel: UILabel {
    
    public enum Status {
        case unknown
        case isValid
        case isInvalid
    }
    
    let defaultTextColor: UIColor
    
    var status: Status {
        didSet {
            switch status {
            case .unknown:
                textColor = defaultTextColor
            case .isValid:
                textColor = .init(red: 0, green: 100/255, blue: 0, alpha: 1)
            case .isInvalid:
                textColor = .red
            }
        }
    }

    init(defaultTextColor: UIColor) {
        self.defaultTextColor = defaultTextColor
        self.status = .unknown
        super.init(frame: .zero)

        self.textColor = defaultTextColor
        self.toAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(text: String?, status: Status) {
        self.status = status
        self.text = text
    }

}
