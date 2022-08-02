import Foundation
import FirebaseAuth

enum CheckerServiceError: Error {
    case loginIsEmpty
    case passwordIsEmpty
    case incorrect
}

final class CheckerService: CheckerServiceProtocol {
    
    public static let shared: CheckerService = CheckerService()
    
    func checkCredentials(loginEntry: String, passwordEntry: String, completion: @escaping ((User?, Error?) -> Void ))  {
        print("checkCredentials..")
        do {
            FirebaseAuth.Auth.auth().signIn(withEmail: loginEntry, password: passwordEntry) { authDataResult, error in
                
                var user: User?
                
                if let unwrapedError = error {
                    print("unwrapedError = \(unwrapedError.localizedDescription)")
                }
                
                if let unwrapedAuthDataResult = authDataResult {
                    print("unwrapedAuthDataResult = \(unwrapedAuthDataResult)")
                    
                    print("user.displayName = \(unwrapedAuthDataResult.user.displayName ?? "" )")
                    print("user.email = \(unwrapedAuthDataResult.user.email ?? "" )")
                    print("user.uid = \(unwrapedAuthDataResult.user.uid)")
                    print("user.photoURL = \(String(describing: unwrapedAuthDataResult.user.photoURL))")

                    let userProfile = UserProfile(name: loginEntry,
                                                  password: passwordEntry,
                                                  fullName: unwrapedAuthDataResult.user.displayName ?? "",
                                                  avatarImage: nil,
                                                  status: .active,
                                                  email: unwrapedAuthDataResult.user.email,
                                                  uid: unwrapedAuthDataResult.user.uid,
                                                  photoURL: unwrapedAuthDataResult.user.photoURL)
                    
                    user = User(profile: userProfile)
                }
                
                completion(user, error)
            }
            
         }
        
    }
    
    func signUp(loginEntry: String, passwordEntry: String, completion: @escaping ((Error?) -> Void ))  {
        print("signUp..")
        do {
            FirebaseAuth.Auth.auth().createUser(withEmail: loginEntry, password: passwordEntry) { authDataResult, error in
                if let unwrapedError = error {
                    print("unwrapedError = \(unwrapedError.localizedDescription)")
                }
                completion(error)
            }
         }
    }
}

