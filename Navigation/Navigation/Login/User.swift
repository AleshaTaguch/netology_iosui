//
//  User.swift
//  Navigation
//
//  Created by tertyshniy on 28.04.2022.
//

import Foundation
import UIKit

enum StatusUser: String {
    case active = "Активный"
    case bloked = "Заблокированный"
}

class User {
    let name: String
    let password: String
    let fullName: String
    let avatarImage: UIImage?
    let status: StatusUser
    
    init(name: String, password: String, fullName: String, avatarImage: UIImage?, status: StatusUser ) {
        self.name = name
        self.password = password
        self.fullName = fullName
        self.avatarImage = avatarImage
        self.status = status
    }
}

protocol UserService {
    func getUserObjectbyName(_ name: String) -> User?
}


class CurrentUserService: UserService {
    
    private let user: User?
    
    init() {
        self.user = Constants.Users.userReleace
    }

    func getUserObjectbyName(_ name: String) -> User? {
        guard let valueUserName = user?.name else { return nil }
        if valueUserName == name {
            return user
        } else {
            return nil
        }
    }
}

class TestUserService: UserService {
    
    private let user: User?
    
    init() {
        self.user = Constants.Users.userDebug
    }

    func getUserObjectbyName(_ name: String) -> User? {
        guard let valueUserName = user?.name else { return nil }
        if valueUserName == name {
            return user
        } else {
            return nil
        }
    }
}

