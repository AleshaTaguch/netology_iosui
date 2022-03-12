import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let classIdentifier: String = "PostTableViewCell"
    
    let postTitleLabel: UILabel = {
        let postTitleLabel = UILabel()
        postTitleLabel.font = UIFont.systemFont(ofSize: Constants.PostViewCell.fortSizeHeader, weight: .bold)
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
        postDescriptionLabel.font = UIFont.systemFont(ofSize: Constants.PostViewCell.fortSizeBody, weight: .regular)
        postDescriptionLabel.textColor = .black
        postDescriptionLabel.numberOfLines = 0
        postDescriptionLabel.toAutoLayout()
        return postDescriptionLabel
    }()
    
    let postLikesLabel: UILabel = {
        let postLikesLabel = UILabel()
        postLikesLabel.font = UIFont.systemFont(ofSize: Constants.PostViewCell.fortSizeFoter, weight: .regular)
        postLikesLabel.textColor = .black
        postLikesLabel.toAutoLayout()
        return postLikesLabel
    }()
    
    let postViewsLabel: UILabel = {
        let postViewsLabel = UILabel()
        postViewsLabel.font = UIFont.systemFont(ofSize: Constants.PostViewCell.fortSizeFoter, weight: .regular)
        postViewsLabel.textColor = .black
        postViewsLabel.toAutoLayout()
        return postViewsLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(postTitleLabel,
                                postImageView,
                                postDescriptionLabel,
                                postLikesLabel,
                                postViewsLabel)
        
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
    
}

extension PostTableViewCell {
    
    public func setCellFromDataSet(_ post: Post) {
        self.postTitleLabel.text = post.title
        self.postImageView.image = UIImage(named: post.image)
        self.postDescriptionLabel.text = post.description
        self.postLikesLabel.text = "Likes: \(post.likes)"
        self.postViewsLabel.text = "Views: \(post.views)"
    }

}

extension PostTableViewCell {
    
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            postTitleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Constants.PostViewCell.allMargin),
            postTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.PostViewCell.allMargin),
            postTitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constants.PostViewCell.allMargin),
            
            postImageView.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: Constants.PostViewCell.allMargin),
            postImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            postImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            postImageView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor),
            
            postDescriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: Constants.PostViewCell.allMargin),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.PostViewCell.allMargin),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            postDescriptionLabel.bottomAnchor.constraint(equalTo: postLikesLabel.topAnchor, constant: -Constants.PostViewCell.allMargin),
            
            postLikesLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.PostViewCell.allMargin),
            postLikesLabel.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant: -Constants.PostViewCell.allMargin),
            
            postViewsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constants.PostViewCell.allMargin),
            postViewsLabel.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant: -Constants.PostViewCell.allMargin)

        ])
    }
}
