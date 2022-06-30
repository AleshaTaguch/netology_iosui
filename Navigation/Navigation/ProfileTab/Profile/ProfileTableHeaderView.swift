import UIKit
import StorageService

class ProfileTableHeaderView: UIView {
    
    let postsArray: [Post] = sourcePostsArray
    
    weak var userServiceDeligate: UserServiceDeligate?
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.isScrollEnabled = true
        tableView.separatorInset = .zero
        tableView.separatorStyle = .singleLine
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 228
        tableView.sectionFooterHeight = 0
        tableView.estimatedSectionFooterHeight = 0 
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.backgroundColor = .systemGray6
        tableView.toAutoLayout()
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
   
        self.backgroundColor = .white
        self.addSubviews(tableView)

        activateConstraints()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.classIdentifier)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.classIdentifier)
        
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.classIdentifier)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ProfileTableHeaderView: UITableViewDataSource ,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.classIdentifier, for: indexPath) as! PhotoTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.classIdentifier, for: indexPath) as! PostTableViewCell
            cell.setCellFromDataSet(postsArray[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return postsArray.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.classIdentifier) as! ProfileHeaderView
            if let valueUser = userServiceDeligate?.getUserObject() {
                header.setProfileFromUser(valueUser)
            }
            return header
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
      
}

extension ProfileTableHeaderView {
    
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

}
