/*
import Foundation
import UIKit


final class AppMainFactory {

    enum ModuleName {
        case login
        case profile
        case feed
    }
    
    private func makeModuleFeed() -> UIViewController  {
        let feedViewController = FeedViewController()
        return feedViewController
    }
    
    private func makeModuleProfile() -> UIViewController   {
        let profileViewController = ProfileViewController()
        return profileViewController
    }
    
    private func makeModuleLogin() -> UIViewController  {
        let loginViewController = LoginViewController()
        loginViewController.loginCheckerDeligate = LoginFactory.share.makeLoginInpector()
        return loginViewController
    }
    
    public func startModule(module: ModuleName) -> UIViewController {
        switch module {
        case .feed:
            return makeModuleFeed()
        case .profile:
            return makeModuleProfile()
        case .login:
            return makeModuleLogin()
        }
        
    }
    
}

 */
