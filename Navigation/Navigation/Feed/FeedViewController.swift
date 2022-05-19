import UIKit
import SnapKit
import StorageService

class FeedViewController: UIViewController {
    
    var coordinatorDeligate: FeedCoordinatorProtocol?
    
    let model: FeedModel = FeedModel()
    
    var currentPost: Post?
    
    lazy var button1: CustomButton = CustomButton(frame: .zero, title: "Go Post View 1") { self.showPost() }

    lazy var button2: CustomButton = CustomButton(frame: .zero, title: "Go Post View 2") { self.showPost() }
    
    let buttonsSteckView: UIStackView = {
        let buttonsSteckView = UIStackView()
        buttonsSteckView.frame = CGRect(x: 50, y: 50, width: 400, height: 100)
        buttonsSteckView.axis = .vertical
        buttonsSteckView.spacing = 10
        buttonsSteckView.distribution = .fillEqually
        buttonsSteckView.toAutoLayout()
        return buttonsSteckView
    }()
    
    lazy var addedFeedView: FeedView = {
        let addedFeedView = FeedView(frame: .zero)
        addedFeedView.deligate = self
        addedFeedView.toAutoLayout()
        return addedFeedView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Feed"
        
        buttonsSteckView.addArrangedSubviews(button1,button2)

        view.addSubviews(buttonsSteckView,addedFeedView)
        
        activateConstraints()
        
    }
    
}

extension FeedViewController {
    
    @objc func showPost() {
        currentPost = Post(title: "Post 12345", author: "?", description: "?", image: "?", likes: 0, views: 0)
        if let valueCorrentPost = currentPost, let coordinator = coordinatorDeligate {
            coordinator.doEventHandle(with: .showPost(valueCorrentPost))
        }
    }
    
}

extension FeedViewController: FeedViewDeligate {
    
    func checkWord(word: String) -> (isValid: Bool, resultText: String) {
        let modelCheck = model.check(word: word)
        return modelCheck
    }
    
    
}

extension FeedViewController {
    private func activateConstraints () {
        
        buttonsSteckView.snp.makeConstraints { make in
            make.center.equalTo(self.view.snp.center)
            make.height.equalTo(90)
            make.width.equalTo(self.view.snp.width).multipliedBy(0.6)
        }
        
        addedFeedView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(12)
            make.centerX.equalTo(self.view.snp.centerX)
            make.height.equalTo(105)
            make.width.equalTo(self.view.snp.width).inset(24)
        }

    }
}
