import Foundation

enum CheckerError: Error {
    case loginIsEmpty
    case passwordIsEmpty
    case incorrect
}

class Checker {
    
    public static let shared: Checker = Checker()
    
    private let refereceUserProfile: UserProfile
    
    private init() {
#if DEBUG
    self.refereceUserProfile = UserProfile(name: Constants.Users.userDebug.profile.name,
                                           password: Constants.Users.userDebug.profile.password,
                                           fullName: Constants.Users.userDebug.profile.fullName,
                                           avatarImage: Constants.Users.userDebug.profile.avatarImage,
                                           status: .active,
                                           email: nil,
                                           uid: nil,
                                           photoURL: nil)
#else
    self.refereceUserProfile = UserProfile(name: Constants.Users.userReleace.profile.name,
                                           password: Constants.Users.userReleace.profile.password,
                                           fullName: Constants.Users.userReleace.profile.fullName,
                                           avatarImage: Constants.Users.userReleace.profile.avatarImage,
                                           status: .active,
                                           email: nil,
                                           uid: nil,
                                           photoURL: nil)
#endif
    }
    
    func checkCorrect(loginEntry: String, passwordEntry: String) throws {
        if loginEntry == "" {
            throw CheckerError.loginIsEmpty
        } else if passwordEntry == "" {
            throw CheckerError.passwordIsEmpty
        } else if loginEntry == self.refereceUserProfile.name && passwordEntry == self.refereceUserProfile.password {
            return
        } else {
            throw CheckerError.incorrect
        }
    }

    
    func checkCorrect(loginEntry: String, passwordEntry: String, completion: @escaping ((User?, Error?) -> Void ) ) {
        
        if loginEntry == "" {
            completion(nil,CheckerError.loginIsEmpty)
        } else if passwordEntry == "" {
            completion(nil,CheckerError.passwordIsEmpty)
        } else if loginEntry == self.refereceUserProfile.name && passwordEntry == self.refereceUserProfile.password {
            //let user = User(profile: self.refereceUserProfile)
            completion(User(profile: self.refereceUserProfile), nil )
        } else {
            completion(nil, CheckerError.incorrect)
        }
    }
}


