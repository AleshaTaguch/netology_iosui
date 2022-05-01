//
//  UserChecker.swift
//  Navigation
//
//  Created by tertyshniy on 01.05.2022.
//

import Foundation


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
    
    func isCorrect(loginEntry: String, passwordEntry: String) -> Bool {
        if self.login == loginEntry && self.password == passwordEntry {
            return true
        } else {
            return false
        }
    }
    
}


