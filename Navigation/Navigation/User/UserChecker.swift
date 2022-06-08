import Foundation

enum CheckerError: Error {
    case loginIsEmpty
    case passwordIsEmpty
    case incorrect
}

class Checker {
    
    public static let shared: Checker = Checker()
    
    private let login: String
    private let password: String
    
    private init() {
#if DEBUG
        self.login = Constants.Users.userDebug.name
        self.password = Constants.Users.userDebug.password
#else
        self.login = Constants.Users.userReleace.name
        self.password = Constants.Users.userReleace.password
#endif
    }
    
    func checkCorrect(loginEntry: String, passwordEntry: String) throws {
        if loginEntry == "" {
            throw CheckerError.loginIsEmpty
        } else if passwordEntry == "" {
            throw CheckerError.passwordIsEmpty
        } else if loginEntry == self.login && passwordEntry == self.password {
            return
        } else {
            throw CheckerError.incorrect
        }
    }
    
}


