import UIKit

class LoginViewController: UIViewController {
     
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: LoginHeaderView = {
        let contentView = LoginHeaderView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "LogIn"
        
        scrollView.contentSize = CGSize(width: self.view.safeAreaLayoutGuide.layoutFrame.width
                                       ,height: self.view.safeAreaLayoutGuide.layoutFrame.height )
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        activateConstraints()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
        
        // подписаться на уведомления
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        contentView.pwdTextField.resignFirstResponder()
        contentView.loginTextField.resignFirstResponder()
        
        /*
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector:  #selector(kbdShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
         */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // подписаться на уведомления
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // отписаться от уведомлений
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}




// MARK: Extensions

extension LoginViewController {
    
    @objc private func kbdShow(notification: NSNotification) {
     if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
     scrollView.contentInset.bottom = kbdSize.height
     scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
     }
    }
    @objc private func kbdHide(notification: NSNotification) {
     scrollView.contentInset.bottom = .zero
     scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc func tap() {
        contentView.pwdTextField.resignFirstResponder()
        contentView.loginTextField.resignFirstResponder()
    }
    
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
    
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
    }
}
