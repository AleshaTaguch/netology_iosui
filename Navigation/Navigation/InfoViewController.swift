import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        self.title = "Info"
        
        let button = UIButton(frame: CGRect(x: 50, y: 100, width: 200, height: 50))
        button.setTitle("Go Alert", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        self.view.addSubview(button)
        
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
