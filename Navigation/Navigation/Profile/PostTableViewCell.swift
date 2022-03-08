//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by tertyshniy on 08.03.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    let postTitleLabel: UILabel = {
        let postTitleLabel = UILabel()
        postTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        postTitleLabel.textColor = .black
        postTitleLabel.numberOfLines = 2
        postTitleLabel.toAutoLayout()
        return postTitleLabel
    }()
    
    let postImageView: UIImageView = {
        let postImageView = UIImageView()
        postImageView.contentMode = .scaleAspectFit
        postImageView.backgroundColor = .black
        postImageView.toAutoLayout()
        return postImageView
    }()
    
    let postDescriptionLabel: UILabel = {
        let postDescriptionLabel = UILabel()
        postDescriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        postDescriptionLabel.textColor = .black
        postDescriptionLabel.numberOfLines = 0
        postDescriptionLabel.toAutoLayout()
        return postDescriptionLabel
    }()
    
    let postLikesLabel: UILabel = {
        let postLikesLabel = UILabel()
        postLikesLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        postLikesLabel.textColor = .black
        postLikesLabel.toAutoLayout()
        return postLikesLabel
    }()
    
    let postViewsLabel: UILabel = {
        let postViewsLabel = UILabel()
        postViewsLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        postViewsLabel.textColor = .black
        postViewsLabel.toAutoLayout()
        return postViewsLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    
        //self.addSubviews(postTitleLabel,postImageView,postDescriptionLabel,postLikesLabel,postViewsLabel)
        
        contentView.addSubviews(postTitleLabel,
                                postImageView,
                                postDescriptionLabel,
                                postLikesLabel,
                                postViewsLabel)
        //backgroundColor = .cyan
        //contentView.backgroundColor = .blue
        self.toAutoLayout()
        activateConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}

extension PostTableViewCell {
    
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            postTitleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            postTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            postTitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            
            postImageView.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 16),
            postImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            postImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            postImageView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor),
            
            postDescriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            postDescriptionLabel.bottomAnchor.constraint(equalTo: postLikesLabel.topAnchor, constant: -16),
            
            postLikesLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            postLikesLabel.heightAnchor.constraint(equalToConstant: 20),
            postLikesLabel.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant: -16),
            
            postViewsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            postViewsLabel.heightAnchor.constraint(equalToConstant: 20),
            postViewsLabel.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant: -16)

        ])
    }
}
