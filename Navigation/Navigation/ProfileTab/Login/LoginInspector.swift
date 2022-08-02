import Foundation

final class LoginInspector: LoginInspectorProtocol {

    enum RegexCheracterSet: String {
        case login = "^([a-z0-9!#$%&'*+-/=?^_`{|}~]){1,64}@([a-z0-9!#$%&'*+-/=?^_`{|}~]){1,64}\\.([a-z0-9]){2,64}$"
        case password = "^([a-z0-9!#$%^&*-_+=]){6,}$"
    }
    
    func checkCorrectLoginPassword(loginEntry: String, passwordEntry: String) throws {
        print("LoginInspector.checkCorrectLoginPassword ",loginEntry, " / ", passwordEntry)
        try Checker.shared.checkCorrect(loginEntry: loginEntry, passwordEntry: passwordEntry)
    }
    
    private func validatedString(_ stringEntry: String, pattern: RegexCheracterSet) -> Bool {
            let regex =  "^([a-z0-9!#$%^&*-_+=]){6,}$"
            let predicate = NSPredicate(format:"SELF MATCHES %@",regex)
            let result = predicate.evaluate(with: stringEntry)
            return result
        }
    
    // firebase
    
    func checkCredentials(loginEntry: String, passwordEntry: String, completion: @escaping ((UserService?, Error?) -> Void )) {
        print("LoginInspector.checkCredentials ",loginEntry, " / ", passwordEntry)
        CheckerService.shared.checkCredentials(loginEntry: loginEntry, passwordEntry: passwordEntry) { user, error in
            print("LoginInspector.checkCredentials completion..")
            if let unwrapedError = error {
                print("unwrapedError = \(unwrapedError.localizedDescription)")
                completion(nil,error)
                
            } else if let unwrapperUser = user {
                print("unwrapperUser = \(unwrapperUser.profile)")
                let userService = CurrentUserService(user: unwrapperUser)
                completion(userService,error)
            }
        }
        
    }
    
    func SignUp(loginEntry: String, passwordEntry: String, completion: @escaping ((Error?) -> Void )) {
        print("LoginInspector.SignUp ",loginEntry, " / ", passwordEntry)
        if !validatedString(loginEntry, pattern: .login) {
            completion(LoginInspectorError.invalidLogin
            )
        }
        if !validatedString(passwordEntry, pattern: .password) {
            completion(LoginInspectorError.invalidPassword
            )
        }
        
        CheckerService.shared.signUp(loginEntry: loginEntry, passwordEntry: passwordEntry) { error in
            print("LoginInspector.signUp completion..")
            if let unwrapedError = error {
                print("unwrapedError = \(unwrapedError.localizedDescription)")
            }
            completion(error)
        }
    }
    
}
