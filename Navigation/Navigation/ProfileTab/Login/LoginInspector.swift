import Foundation

final class LoginInspector: LoginInspectorProtocol {

    enum RegexCheracterSet: String {
        case login =  "^([a-z0-9!#$%&'*+-/=?^_`{|}~]){1,64}@([a-z0-9!#$%&'*+-/=?^_`{|}~]){1,64}\\.([a-z0-9]){2,64}$"
        case password = "^([a-z0-9!#$%^&*-_+=]){6,}$"
    }
    
    private func validatedString(_ stringEntry: String, pattern: RegexCheracterSet) -> Bool {
        let regex =  pattern as! CVarArg
        let predicate = NSPredicate(format:"SELF MATCHES %@",regex)
        let result = predicate.evaluate(with: stringEntry)
        return result
    }
    
    func checkCorrectLoginPassword(loginEntry: String, passwordEntry: String) throws {
        print("LoginInspector.checkCorrectLoginPassword ",loginEntry, " / ", passwordEntry)
        try Checker.shared.checkCorrect(loginEntry: loginEntry, passwordEntry: passwordEntry)
    }
    
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
    
}
