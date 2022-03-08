import UIKit

class LoginViewController: UIViewController {
    
    public var isLogined: Bool = false
     
     let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    let contentView: LoginHeaderView = {
        let contentView = LoginHeaderView()
        contentView.toAutoLayout()
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isLogined = false
        self.view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        activateConstraints()
        
        // прячем клавиатуру
        let tapGestureeRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToHideKeyboard))
        view.addGestureRecognizer(tapGestureeRecognizer)
        
        contentView.loginButton.addTarget(self, action: #selector(pressButtonLogin), for: .touchUpInside)
        
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
        
        scrollView.contentSize = CGSize(width: self.view.safeAreaLayoutGuide.layoutFrame.size.width
                                       ,height: self.contentView.loginButton.frame.origin.y +
                                                self.contentView.loginButton.frame.size.height )
        
        
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
    
    @objc func pressButtonLogin() {
        navigationController?.popViewController(animated: true)
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
