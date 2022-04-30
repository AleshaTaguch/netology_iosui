import UIKit

struct Constants {
    struct PhotosTable {
        static let topMargin: CGFloat = 12
        static let leftMargin: CGFloat = 12
        static let rightMargin: CGFloat = 12
        static let buttomMargin: CGFloat = 12
        static let interitemSpacing: CGFloat = 8
        static let countPhotos: Int = 4
    }
    struct PhotosCollection {
        static let topMargin: CGFloat = 8
        static let leftMargin: CGFloat = 8
        static let rightMargin: CGFloat = 8
        static let buttomMargin: CGFloat = 8
        static let lineSpacing: CGFloat = 8
        static let interitemSpacing: CGFloat = 8
        static let countColumns: Int = 3
        
    }
    struct ProfileView {
        struct AvatarImage {
            static let topMargin: CGFloat = 16
            static let leftMargin: CGFloat = 16
            static let size: CGFloat = 130.0  //130+16+16+50+16=180+48=228
        }
        struct StatusButton {
            static let topMargin: CGFloat = 16
            static let leftMargin: CGFloat = 16
            static let rightMargin: CGFloat = 16
            static let buttomMargin: CGFloat = 16
            static let height: CGFloat = 50
        }
        struct FullName {
            static let topMargin: CGFloat = 27
            static let leftMargin: CGFloat = 16
            static let rightMargin: CGFloat = 16
            static let buttomMargin: CGFloat = 16
            static let height: CGFloat = 25
        }
        struct StatusLabel {
            static let leftMargin: CGFloat = 16
            static let rightMargin: CGFloat = 16
            static let buttomMargin: CGFloat = 50
            static let height: CGFloat = 25
        }
        struct StatusField {
            static let topMargin: CGFloat = 3
            static let leftMargin: CGFloat = 16
            static let rightMargin: CGFloat = 16
            static let height: CGFloat = 40
        }

    }
    struct PostViewCell {
        static let fortSizeHeader: CGFloat = 20
        static let fortSizeBody: CGFloat = 14
        static let fortSizeFoter: CGFloat = 16
        static let allMargin: CGFloat = 16.0
    }
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
    
    struct Users {
        static let userReleace: User = User(name: "Authur",
                                            password: "123",
                                            fullName: "Arthur Fellig (Weegee)",
                                            avatarImage: UIImage(named: "UserImage"),
                                            status: .active)
        static let userDebug: User = User(name: "Test",
                                            password: "123",
                                            fullName: "Test Testov (DEBUG)",
                                            avatarImage: UIImage(named: "UserImageDebug"),
                                            status: .active)
    }
}


 
