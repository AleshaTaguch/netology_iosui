import Foundation

protocol LoginInspectorProtocol: AnyObject {
    func checkCorrectLoginPassword(loginEntry: String, passwordEntry: String) throws
}

class LoginInspector: LoginInspectorProtocol {

    func checkCorrectLoginPassword(loginEntry: String, passwordEntry: String) throws {
        print("LoginInspector ",loginEntry, " / ", passwordEntry)
        try Checker.shared.checkCorrect(loginEntry: loginEntry, passwordEntry: passwordEntry)
    }
    
}
