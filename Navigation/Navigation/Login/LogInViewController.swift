import UIKit

class LoginViewController: UIViewController {
         
     let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    lazy var contentView: LoginHeaderView = {
        let contentView = LoginHeaderView(deligate: self)
        contentView.toAutoLayout()
        return contentView
    }()
    
    var loginCheckerDeligate: LoginViewControllerDeligate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        activateConstraints()
        
        // прячем клавиатуру если тапаем по вьюшке, а не по полю ввода
        let tapGestureeRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToHideKeyboard))
        view.addGestureRecognizer(tapGestureeRecognizer)
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // подписаться на уведомления
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: self.contentView.frame.size.width
                                       ,height: self.contentView.frame.size.height)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // отписаться от уведомлений
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}


// MARK: Extensions

extension LoginViewController: LoginHeaderViewDeligate {
    
    func tapLoginButton(login: String, password: String) {
        
        if login == "" {
            showAlertOK(title: "User name is empty", message: "Enter correct userName and password!")
            return
        }
        if password == "" {
            showAlertOK(title: "User password is empty", message: "Enter correct userName and password!")
            return
        }
        
        guard let isCorrectValue = loginCheckerDeligate?.isCorrectLoginPassword(loginEntry: login,
                                                                                passwordEntry: password) else { return }
        
        if !isCorrectValue {
            showAlertOK(title: "Invalid user name or password", message: "Enter correct userName and password!")
            return
        }
        
        var currentUserService: UserService
#if DEBUG
        currentUserService = TestUserService()
#else
        currentUserService = CurrentUserService()
#endif
        
        let profileViewController = ProfileViewController(currentUser: currentUserService, currentUserName: login)
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.setViewControllers([profileViewController], animated: true)
    }
    
    func showAlertOK(title: String, message: String) {
        let alertOkViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertOkViewController.addAction(actionOk)
        self.present(alertOkViewController, animated: true, completion: nil)
    }

}

extension LoginViewController {

    @objc private func showKeyboard(notification: NSNotification) {
        if let keyboardRectValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardRectValue.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardRectValue.height, right: 0)
        }
    }
    
    @objc private func hideKeyboard(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc private func tapToHideKeyboard() {
        contentView.endEditing(false)
    }
    
}

extension LoginViewController {
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
    
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
}
