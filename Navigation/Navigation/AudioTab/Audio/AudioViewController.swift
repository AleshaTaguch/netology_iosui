import UIKit

class AudioViewController: UIViewController {
    
    lazy var audioView: AudioView = {
        let audioView = AudioView()
        audioView.toAutoLayout()
        return audioView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Audio"
        
        view.addSubviews(audioView)
        
        activateConstraints()

    }
    
    
    private func activateConstraints () {
        audioView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }



}
