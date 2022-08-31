import UIKit
import SnapKit

final class SettingsView: UIView {
    
    private weak var delegate: SettingsViewDelegateProtocol?
    
    
    let sortLabel: UILabel = {
        let sortLabel = UILabel()
        sortLabel.text = "Сортировать в обратном порядке"
        sortLabel.font = UIFont.systemFont(ofSize: 18)
        sortLabel.toAutoLayout()
        return sortLabel
    }()
    
    
    lazy var sortSwitch: UISwitch = {
        let sortSwitch = UISwitch()
        //if let valueSortFileKey = UserDefaults.standard.value(forKey: SettingsKey.sortFileKey)
        sortSwitch.isOn = UserDefaults.standard.bool(forKey: SettingsKey.sortFileKey)
        sortSwitch.addTarget(self, action: #selector(tapChangeSortSwitch), for: .valueChanged)
        return sortSwitch
    }()
    
    
    private lazy var changePinCode: CustomButton = CustomButton(frame: .zero, title: "Сменить пароль") { self.tapChangePinCodeButton() }
    
    
    init(delegate: SettingsViewDelegateProtocol?) {
        super.init(frame: .zero)
        self.delegate = delegate

        self.addSubviews(sortLabel,
                         sortSwitch,
                         changePinCode
        )
        
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func activateConstraints () {
        sortLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(40)
            make.top.equalToSuperview().inset(16)
        }
        
        sortSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(sortLabel.snp.centerY)
        }

        changePinCode.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(sortLabel.snp.bottom).offset(10)
        }
    }
    
    private func tapChangePinCodeButton() {
        guard let valueDelegate = delegate else { return }
        valueDelegate.doShowSetPinCode()
    }
    
    @objc private func tapChangeSortSwitch() {
        print("sortSwitch = ", sortSwitch.isOn)
        UserDefaults.standard.set(sortSwitch.isOn, forKey: SettingsKey.sortFileKey)
    }
    
}

