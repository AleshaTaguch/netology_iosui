import UIKit

class ProfileTableHeaderView: UIView {
    
    let postsArray: [Post] = sourcePostsArray

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.isScrollEnabled = true
        tableView.separatorInset = .zero
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ProfileTableHeaderView: UITableViewDataSource ,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.classIdentifier, for: indexPath) as! PostTableViewCell
        cell.setCellFromDataSet(postsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.classIdentifier) as! ProfileHeaderView
            return header
        } else {
            return nil
        }
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
