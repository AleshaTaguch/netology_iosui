//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by tertyshniy on 07.03.2022.
//

import UIKit

class ProfileTableHeaderView: UIView {
    
    let postsArray: [Post] = sourcePostsArray

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.refreshControl = UIRefreshControl()
        //tableView.isScrollEnabled = true
        //tableView.separatorInset = .zero
        tableView.refreshControl?.addTarget(self, action: #selector(updatePostArray), for: .valueChanged)
        //tableView.sectionHeaderHeight = UITableView.automaticDimension
        //tableView.estimatedSectionHeaderHeight = 220
        //tableView.rowHeight = UITableView.automaticDimension

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
 
        //tableView.sectionHeaderHeight = UITableView.automaticDimension
        //tableView.estimatedSectionHeaderHeight = 220
        
        tableView.backgroundColor = .white
        
        tableView.toAutoLayout()
        //tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostsArray")
        //tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
   
        self.backgroundColor = .red
        self.addSubviews(tableView)

        activateConstraints()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //tableView.register(PostTableViewCell.self, forCellReuseIdentifier: <#T##String#>)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostsArray")
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ProfileTableHeaderView: UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsArray", for: indexPath) as! PostTableViewCell
        cell.postTitleLabel.text = postsArray[indexPath.row].title
        cell.postImageView.image = UIImage(named: postsArray[indexPath.row].image)
        cell.postDescriptionLabel.text = postsArray[indexPath.row].description
        cell.postLikesLabel.text = "Likes: \(postsArray[indexPath.row].likes)"
        cell.postViewsLabel.text = "Views: \(postsArray[indexPath.row].views)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //    return 500// UITableView.automaticDimension
    //}
    
    //func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //    return 180
    //}
    
    @objc func updatePostArray() {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
        tableView.beginUpdates()
        tableView.endUpdates()
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
