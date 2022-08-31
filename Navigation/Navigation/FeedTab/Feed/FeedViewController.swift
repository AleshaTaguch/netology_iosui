import UIKit
import SnapKit
import StorageService

final class FeedViewController: UIViewController, FeedViewDeligateProtocol {
    
    weak var coordinatorDeligate: FeedCoordinatorProtocol?
    var viewModel: FeedViewModel = FeedViewModel()
    
    var currentPost: Post?
    
    lazy var button1: CustomButton = CustomButton(frame: .zero, title: "Go Post View 1") { self.showPost() }

    lazy var button2: CustomButton = CustomButton(frame: .zero, title: "Go Post View 2") { self.showPost() }
    
    lazy var showDirDocumentsButton: CustomButton = CustomButton(frame: .zero, title: "Dir Documents") { self.showDirDocuments() }
    
    let buttonsSteckView: UIStackView = {
        let buttonsSteckView = UIStackView()
        //buttonsSteckView.frame = CGRect(x: 50, y: 50, width: 400, height: 100)
        buttonsSteckView.axis = .vertical
        buttonsSteckView.spacing = 10
        buttonsSteckView.distribution = .fillEqually
        buttonsSteckView.toAutoLayout()
        return buttonsSteckView
    }()
    
    lazy var addedFeedView: FeedView = {
        let addedFeedView = FeedView(deligate: self)
        addedFeedView.toAutoLayout()
        return addedFeedView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Feed"
        
        buttonsSteckView.addArrangedSubviews(button1,button2,showDirDocumentsButton)

        view.addSubviews(buttonsSteckView,addedFeedView)
        
        activateConstraints()
        
    }
    

    @objc func showPost() {
        currentPost = Post(title: "Post 12345", author: "?", description: "?", image: "?", likes: 0, views: 0)
        if let valueCorrentPost = currentPost, let coordinator = coordinatorDeligate {
            coordinator.doEventHandle(with: .showPost(valueCorrentPost))
        }
    }
    
    @objc func showDirDocuments() {
        if let coordinator = coordinatorDeligate {
            //coordinator.doEventHandle(with: .showDirDocuments)
        }
    }
    
}

extension FeedViewController {
    private func activateConstraints () {
        
        addedFeedView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(12)
            make.centerX.equalTo(self.view.snp.centerX)
            make.height.equalTo(105)
            make.width.equalTo(self.view.snp.width).inset(24)
        }
        
        buttonsSteckView.snp.makeConstraints { make in
            make.top.equalTo(self.addedFeedView.snp.bottom).offset(12)
            make.centerX.equalTo(self.view.snp.centerX)
            make.height.equalTo(135)
            make.width.equalTo(self.view.snp.width).inset(24)
        }
        

    }
}
