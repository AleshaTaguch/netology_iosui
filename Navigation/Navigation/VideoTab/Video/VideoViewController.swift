import UIKit
import AVKit

class VideoViewController: UIViewController {
    
    lazy var videoView: VideoView = {
        let videoView = VideoView()
        videoView.videoPlayerDeligare = self
        videoView.toAutoLayout()
        return videoView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Video"
        
        view.addSubviews(videoView)
        
        activateConstraints()

    }
    
    
    private func activateConstraints () {
        videoView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }

}

extension VideoViewController: VideoPlayerDeligare {
    func play(urlString: String) {
        
        guard let urlVideo =  URL(string: urlString) else {return}
        
        if AVAsset(url: urlVideo).isPlayable {
            
            let player = AVPlayer(url: urlVideo)
            
            
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            
            present(playerViewController, animated: true) {
                player.play()
            }
        } else {
            print("AVAsset fail")
            
            let webView =  WebViewController()
            webView.url = urlVideo
            present(webView, animated: true)
            
        }
        

        
    }
    
    
}
