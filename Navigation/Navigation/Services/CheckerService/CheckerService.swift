import Foundation
//import FirebaseAuth

enum CheckerServiceError: Error {
    case loginIsEmpty
    case passwordIsEmpty
    case incorrect
}

final class CheckerService: CheckerServiceProtocol {
    
    public static let shared: CheckerService = CheckerService()
    
    func checkCredentials(loginEntry: String, passwordEntry: String, completion: @escaping ((User?, Error?) -> Void ))  {
        print("Checker.shared.checkCorrect..")
        Checker.shared.checkCorrect(loginEntry: loginEntry, passwordEntry: passwordEntry) { user, error in
            completion(user, error )
        }

        
    }
    
}

