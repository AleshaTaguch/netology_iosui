import Foundation

enum LoginInspectorError: Error {
    case invalidLogin
    case invalidPassword
    
}

extension LoginInspectorError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidLogin:
            return NSLocalizedString("Login does not match the pattern", comment: "Enter correct login")
        case .invalidPassword:
            return NSLocalizedString("Password does not match the pattern", comment: "Enter correct password")
        }
    }
}
