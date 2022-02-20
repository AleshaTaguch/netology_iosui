//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Убрир on 13.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let profileViewName = String(describing: ProfileView.self)
        
        if let profileView = Bundle.main.loadNibNamed(profileViewName, owner: nil, options: nil)?.first as? ProfileView {
            profileView.frame = CGRect(x: 10, y: 45, width: view.bounds.width-20, height: profileView.bounds.height)
            view.addSubview(profileView)

        }
    
    }
    


}
