import Foundation

protocol LoginViewControllerDeligate {
    func isCorrectLoginPassword(loginEntry: String, passwordEntry: String)  -> Bool
}

class LoginInspector: LoginViewControllerDeligate {

    func isCorrectLoginPassword(loginEntry: String, passwordEntry: String) -> Bool {
        print("LoginInspector ",loginEntry, " / ", passwordEntry)
        return Checker.shared.isCorrect(loginEntry: loginEntry, passwordEntry: passwordEntry)
    }
    
}
