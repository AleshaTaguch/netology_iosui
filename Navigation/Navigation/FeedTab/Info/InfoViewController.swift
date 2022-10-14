import UIKit

class InfoViewController: UIViewController {
    
    lazy var button: CustomButton = CustomButton(frame: .zero, title: "Go Alert") { self.showAlert() }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 225.0/255.0, green: 215.0/255.0, blue: 200.0/255.0, alpha: 1)
        self.title = "Info"
        
        self.view.addSubviews(button)
        
        activateConstraints()
        
    }
}

extension InfoViewController {

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

extension InfoViewController {
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6, constant: 0),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            
        ])
    }
}


