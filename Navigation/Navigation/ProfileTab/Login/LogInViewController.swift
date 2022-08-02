import UIKit

final class LoginViewController: UIViewController {
    
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
        
        //return заменен на preconditionFailure() для выполнения задания 4 HW11
        guard let valueLoginCheckerDeligate = loginCheckerDeligate else { preconditionFailure() }
        
        valueLoginCheckerDeligate.checkCredentials(loginEntry: login, passwordEntry: password) { [weak self] userService, error in
            guard let self = self else {return}
            
            if let error = error {
                self.showAlertOK(title: "Checking user name or password", message: error.localizedDescription)
                return
            }
            
            var currentUserService: UserService
    
    #if DEBUG
            currentUserService = TestUserService()
    #else
            if let unwraperUserService = userService {
                currentUserService = unwraperUserService
                if let valueDoEventWhenSuccess = self.doEventWhenSuccess {
                    valueDoEventWhenSuccess(currentUserService,login)
                }
            }
    #endif
        }
        
    }
    
    func tapSignUpButton(login: String, password: String, completion: @escaping (() -> Void )) {
        print("login = \(login)")
        print("password = \(password)")
        guard let valueLoginCheckerDeligate = loginCheckerDeligate else { preconditionFailure() }
        valueLoginCheckerDeligate.SignUp(loginEntry: login, passwordEntry: password) { [weak self] error in
            guard let self = self else {return}
            if let error = error {
                self.showAlertOK(title: "SignUp Error", message: error.localizedDescription)
                return
            } else {
                self.showAlertOK(title: "SignUp Result", message: "User \(login) registered successfully ")
                completion()
            }
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
