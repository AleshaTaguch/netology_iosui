import UIKit

class LoginViewController: UIViewController {
    
    var loginCheckerDeligate: LoginInspectorProtocol?
    var doEventWhenSuccess: ((UserService, String) -> Void)?
         
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

extension LoginViewController: LoginHeaderViewDeligateProtocol {
    
    func tapLoginButton(login: String, password: String) {
        
        guard let valueLoginCheckerDeligate = loginCheckerDeligate else { return }
        
        do {
            try
            valueLoginCheckerDeligate.checkCorrectLoginPassword(loginEntry: login, passwordEntry: password)
        } catch CheckerError.loginIsEmpty {
            showAlertOK(title: "User name is empty", message: "Enter correct userName and password!")
            return
        } catch CheckerError.passwordIsEmpty {
            showAlertOK(title: "User password is empty", message: "Enter correct userName and password!")
            return
        } catch CheckerError.incorrect {
            showAlertOK(title: "Invalid user name or password", message: "Enter correct userName and password!")
            return
        } catch {
            showAlertOK(title: "Checking user name or password", message: "Error unhandled! Please contact with me!")
            return
        }
  
        var currentUserService: UserService
#if DEBUG
        currentUserService = TestUserService()
#else
        currentUserService = CurrentUserService()
#endif
        if let valueDoEventWhenSuccess = doEventWhenSuccess {
            valueDoEventWhenSuccess(currentUserService,login)
        }
        
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
