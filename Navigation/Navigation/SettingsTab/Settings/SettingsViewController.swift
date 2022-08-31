import UIKit

final class SettingsViewController: UIViewController {
    
    weak var coordinatorDeligate: SettingsCoordinatorProtocol?
    
    lazy var settingsView: SettingsView = {
        let view = SettingsView(delegate: self)
        view.toAutoLayout()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Settings"
        
        view.addSubviews(settingsView)
        
        activateConstraints()
                
    }
    
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            settingsView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            settingsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

extension SettingsViewController: SettingsViewDelegateProtocol {
    func doShowSetPinCode() {
        guard let unwrapCoordinatorDeligate = coordinatorDeligate else {return}
        unwrapCoordinatorDeligate.doEventHandle(with: .showPinCodeView)
    }
}
