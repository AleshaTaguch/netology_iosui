import Foundation

enum PinCodeViewMode {
    case createPinMode
    case enterPinMode
}

enum PinCodeViewStageEnter: String {
    case createPin = "Создать пароль"
    case enterPin = "Ввести пароль"
    case reEnterPin = "Повторите пароль"
}

protocol PinCodeViewDelegateProtocol: AnyObject {
    func doActionPinCode(stageEnter: PinCodeViewStageEnter, pinCode: String)
}
