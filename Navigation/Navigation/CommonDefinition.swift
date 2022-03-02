import UIKit

struct Post {
    var title: String
}


struct Constants {
    struct LoginView {
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
        
    }
    struct BlankView {
        static let width: CGFloat = 10
        static let height: CGFloat = 10
    }
    
}

public extension UIView {

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

}

public extension UIStackView {

    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach { addArrangedSubview($0) }
    }

}

/// UIImage alpha https://stackoverflow.com/questions/28517866/how-to-set-the-alpha-of-an-uiimage-in-swift-programmatically

public extension UIImage {

    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
 
