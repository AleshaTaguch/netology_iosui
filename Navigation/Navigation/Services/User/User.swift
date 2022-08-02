import Foundation
import UIKit

enum StatusUser: String {
    case active = "Активный"
    case bloked = "Заблокированный"
}

struct UserProfile {
    var name: String
    var password: String
    var fullName: String
    var avatarImage: UIImage?
    var status: StatusUser
    var email: String?
    var uid: String?
    var photoURL: URL?
}

class User {
    var profile: UserProfile
    
    init(profile : UserProfile) {
        self.profile =  profile
        if self.profile.fullName == "" {
            self.profile.fullName = self.profile.name
        }
        if self.profile.avatarImage == nil {
            self.profile.avatarImage = UIImage(named: "UserImageDefault")
        }
    }
}


enum UserServiceError: Error {
    case notEqualName
    case nameIsNil
}

protocol UserService {
    func getUserObjectbyName(_ name: String) throws -> User?
}

protocol UserServiceDeligate: AnyObject {
    func getUserObject() -> User?
}


final class CurrentUserService: UserService {
    
    private let user: User?

    init() {
        self.user = Constants.Users.userReleace
    }
    
    init(user: User?) {
        self.user = user
    }

    func getUserObjectbyName(_ name: String) throws -> User? {
        guard let valueUserName = user?.profile.name else { throw UserServiceError.nameIsNil }
        if valueUserName == name {
            return user
        } else {
            throw UserServiceError.notEqualName
        }
    }
}

final class TestUserService: UserService {
    
    private let user: User?
    
    init() {
        self.user = Constants.Users.userDebug
    }
    
    init(user: User?) {
        self.user = user
    }

    func getUserObjectbyName(_ name: String) throws -> User? {
        guard let valueUserName = user?.profile.name else { throw UserServiceError.nameIsNil }
        if valueUserName == name {
            return user
        } else {
            throw UserServiceError.notEqualName
        }
    }
}

