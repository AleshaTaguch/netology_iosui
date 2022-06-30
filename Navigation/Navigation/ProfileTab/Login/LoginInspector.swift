import Foundation

protocol LoginInspectorProtocol: AnyObject {
    func isCorrectLoginPassword(loginEntry: String, passwordEntry: String)  -> Bool
}

class LoginInspector: LoginInspectorProtocol {

    func isCorrectLoginPassword(loginEntry: String, passwordEntry: String) -> Bool {
        print("LoginInspector ",loginEntry, " / ", passwordEntry)
        return Checker.shared.isCorrect(loginEntry: loginEntry, passwordEntry: passwordEntry)
    }
    
}
