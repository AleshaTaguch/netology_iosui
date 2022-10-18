//
//  File.swift
//  Navigation
//
//  Created by tertyshniy on 14.09.2022.
//

import Foundation
import RealmSwift

final class UserRealmModel: Object {
    @objc dynamic var name: String?
    @objc dynamic var password: String?
    @objc dynamic var fullName: String?

    

//    @objc dynamic var isNewKey: Bool = true
    
    override static func primaryKey() -> String? {
        return "name"
    }

    convenience init(userProfile: UserProfile) {
        self.init()
        self.name = userProfile.name
        self.password = userProfile.password
        self.fullName = userProfile.fullName
    }
}
