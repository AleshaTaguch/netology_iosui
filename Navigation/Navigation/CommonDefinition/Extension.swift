import UIKit

public extension UIView {
    
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

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

public extension UITextField {

    func setLeftRigthTextMargin() {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.BlankView.width, height: Constants.BlankView.height))
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.BlankView.width, height: Constants.BlankView.height))
        leftViewMode = .always
        rightViewMode = .always
    }
}
