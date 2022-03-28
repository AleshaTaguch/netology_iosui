import UIKit

class InfoViewController: UIViewController {
    
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 225.0/255.0, green: 215.0/255.0, blue: 200.0/255.0, alpha: 1)
        self.title = "Info"
        
        button.setTitle("Go Alert", for: .normal)
        button.backgroundColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = CGFloat(4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        [
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6, constant: 0),
            button.heightAnchor.constraint(equalToConstant: 40)
        ].forEach({$0.isActive = true})
        
    }

    @objc func showAlert() {
        let alertViewController = UIAlertController(title: "Title Alert", message: "Very long message", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Yes", style: .default, handler: (printAlertResult))
        let actionNo = UIAlertAction(title: "No", style: .cancel, handler: (printAlertResult))
        
        alertViewController.addAction(actionYes)
        alertViewController.addAction(actionNo)
        
        self.present(alertViewController, animated: true, completion: nil)
        
    }
    
    func printAlertResult(_ alertAction: UIAlertAction) {
        if let alertButton = alertAction.title {
            print("The \(alertButton) button was pressed.")
        } else {
            print("Button was pressed.")
        }
    }
    
}
