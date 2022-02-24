import UIKit

class ProfileViewController: UIViewController {
    
    let profileHView = ProfileHeaderView()
    let newButtonAtTheBottom = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .lightGray
        self.title = "Profile"
        
        self.view.addSubview(profileHView)
        
        newButtonAtTheBottom.frame = CGRect(x: 1, y: 1, width: 350, height: 50)
        newButtonAtTheBottom.setTitle("New Button At The Bottom", for: .normal)
        newButtonAtTheBottom.backgroundColor = UIColor(red:0x00/255.0, green: 122.0/255.0, blue: 0xFF/255.0, alpha: 1)
        newButtonAtTheBottom.setTitleColor(.white, for: .normal)
        newButtonAtTheBottom.layer.cornerRadius = 4
        newButtonAtTheBottom.layer.masksToBounds = false
        newButtonAtTheBottom.layer.shadowOffset = CGSize(width: 4, height: 4)
        newButtonAtTheBottom.layer.shadowRadius = CGFloat(4)
        newButtonAtTheBottom.layer.shadowColor = UIColor.black.cgColor
        newButtonAtTheBottom.layer.shadowOpacity = 0.7
        self.view.addSubview(newButtonAtTheBottom)
        
        profileHView.translatesAutoresizingMaskIntoConstraints = false
        profileHView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        profileHView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        profileHView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        profileHView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        newButtonAtTheBottom.translatesAutoresizingMaskIntoConstraints = false
        newButtonAtTheBottom.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        newButtonAtTheBottom.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        newButtonAtTheBottom.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                                     constant: 0).isActive = true
        newButtonAtTheBottom.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
   
}

