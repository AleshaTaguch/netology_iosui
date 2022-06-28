import UIKit
import WebKit

class WebViewController: UIViewController {
    
    lazy var webView =  WKWebView()
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "WebView"
        
        view.addSubviews(webView)
        
        activateConstraints()
        if let valueURL = url {
            webView.load(URLRequest(url: valueURL))
        }
    }
    
    
    private func activateConstraints () {
        webView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }



}

