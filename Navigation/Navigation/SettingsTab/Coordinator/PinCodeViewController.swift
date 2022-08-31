import UIKit

final class PinCodeViewController: UIViewController {
    
    private let doEventWhenSuccess: (() -> Void)?
    private let controllerMode: PinCodeViewMode
    
    private lazy var pinCodeView: PinCodeView = {
        let pinCodeView = PinCodeView(delegate: self)
        pinCodeView.toAutoLayout()
        return pinCodeView
    }()
    
    private var pinCodeFirstTry: String = ""
    
    init(mode: PinCodeViewMode, doEventWhenSuccess: @escaping (() -> Void)) {
        self.doEventWhenSuccess = doEventWhenSuccess
        self.controllerMode = mode
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubviews(pinCodeView)

        activateConstraints()
        
        if self.controllerMode == .createPinMode {
            pinCodeFirstTry = ""
            pinCodeView.stageEnter = .createPin
        } else {
            if PinCodeService.shared.existPinCode() {
                pinCodeView.stageEnter = .enterPin
            } else {
                pinCodeFirstTry = ""
                pinCodeView.stageEnter = .createPin
            }
        }
    
    }
    
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            pinCodeView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            pinCodeView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            pinCodeView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            pinCodeView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func showAlertOK(title: String, message: String) {
        let alertOkViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertOkViewController.addAction(actionOk)
        self.present(alertOkViewController, animated: true, completion: nil)
    }
}


extension PinCodeViewController: PinCodeViewDelegateProtocol {
    func doActionPinCode(stageEnter: PinCodeViewStageEnter, pinCode: String) {
        switch stageEnter {
        case .createPin:
            if PinCodeService.shared.validatePinCodeString(pinCode) {
                pinCodeFirstTry = pinCode
                pinCodeView.stageEnter = .reEnterPin
            } else {
                showAlertOK(title: "Ввод пинкода",message: "Пинкод не соотсетствует шаблону. Повторите ввод.")
            }
        case .reEnterPin:
            if pinCode == pinCodeFirstTry {
                print("reEnterPin OK! \(pinCode)")
                pinCodeFirstTry = ""
                PinCodeService.shared.setPinCode(pinCode)
                if let unwrapedDoEventWhenSuccess = doEventWhenSuccess {
                    unwrapedDoEventWhenSuccess()
                }
            } else {
                showAlertOK(title: "Ввод пинкода",message: "Пинкод не совпадает. Введите еще раз.")
                pinCodeFirstTry = ""
                pinCodeView.stageEnter = .createPin
            }
        case .enterPin:
            if PinCodeService.shared.checkPinCode(pinCode) {
                if let unwrapedDoEventWhenSuccess = doEventWhenSuccess {
                    unwrapedDoEventWhenSuccess()
                }
            } else {
                if PinCodeService.shared.remotePinCodeByTry(countTry: 3) {
                    pinCodeView.stageEnter = .createPin
                    showAlertOK(title: "Ввод пинкода",message: "Пинкод не верный, создайте новый.")
                } else {
                    showAlertOK(title: "Ввод пинкода",message: "Пинкод не верный. Введите еще раз.")
                }
            }
        }
    }
}

