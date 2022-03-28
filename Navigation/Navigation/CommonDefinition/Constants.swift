import UIKit

struct Post {
    var title: String
}


struct Constants {
    struct LoginView {
        struct StackView {
            static let height: CGFloat = 510
        }
        struct Logo {
            static let imageName: String = "Logo"
            static let topMargin: CGFloat = 120.0
            static let width: CGFloat = 100
            static let height: CGFloat = 100
        }
        struct StackField {
            static let topMargin: CGFloat = 120.0
            static let leftMargin: CGFloat = 16.0
            static let rigthMargin: CGFloat = 16.0
            static let height: CGFloat = 100
            static let cornerRadius: CGFloat = 10
            static let borderWidth: CGFloat = 0.5
        }
        struct TextField {
            static let borderWidth: CGFloat = 0.5
            static let loginPlaceholderText: String = "Email or phone"
            static let pwdPlaceholderText: String = "Password"
            static let fontSize: CGFloat = 16
            static let height: CGFloat = 50
            static let nameTintColor: String = "accentColor"
        }
        struct LoginButton {
            static let cornerRadius: CGFloat = 10
            static let backgraundImageName: String = "blue_pixel"
            static let titleText: String = "Login"
            static let fontSize: CGFloat = 16
            static let height: CGFloat = 50
            static let topMargin: CGFloat = 16.0
            static let leftMargin: CGFloat = 16.0
            static let rigthMargin: CGFloat = 16.0
        }
    }
    struct BlankView {
        static let width: CGFloat = 10
        static let height: CGFloat = 10
    }
    
}


 
