import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    static let classIdentifier: String = "PhotoTableViewCell"
    static let tapNotificationName: String = "tapImageTapped"
    
    let photoArray: [String] = sourcePhotoArray
    
    let stackView : UIStackView = {
        let photoStackView = UIStackView()
        photoStackView.axis = .horizontal
        photoStackView.spacing = Constants.PhotosTable.interitemSpacing
        photoStackView.distribution = .fillEqually
        photoStackView.toAutoLayout()
        return photoStackView
    }()
    
    let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Photo"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.toAutoLayout()
        return titleLabel
    }()
    
    let titleImage: UIImageView = {
        let titleImage = UIImageView()
        titleImage.image = UIImage(systemName: "arrow.right")
        titleImage.tintColor = .black
        titleImage.toAutoLayout()
        return titleImage
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        for index in 0...Constants.PhotosTable.countPhotos-1 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: photoArray[index])
            imageView.layer.cornerRadius = 6
            imageView.layer.masksToBounds = true
            imageView.contentMode = .scaleAspectFill
            stackView.addArrangedSubview(imageView)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        //tapGestureRecognizer.delegate = ProfileViewController.self
        titleImage.isUserInteractionEnabled = true
        titleImage.addGestureRecognizer(tapGestureRecognizer)
        
        contentView.addSubviews(titleLabel,titleImage,stackView)
        
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


extension PhotoTableViewCell {
    
    @objc func imageTapped(_ recognizer: UITapGestureRecognizer) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: Notification.Name(PhotoTableViewCell.tapNotificationName), object: nil)
    }
    
}

extension PhotoTableViewCell {
    
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Constants.PhotosTable.topMargin),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.PhotosTable.leftMargin),
            
            titleImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            titleImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constants.PhotosTable.rightMargin),
            titleImage.widthAnchor.constraint(equalTo: titleLabel.heightAnchor),
            titleImage.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.PhotosTable.topMargin),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.PhotosTable.leftMargin),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constants.PhotosTable.rightMargin),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -Constants.PhotosTable.buttomMargin),
            stackView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor,
                                              multiplier: 1.0 / CGFloat(Constants.PhotosTable.countPhotos),
                                              constant: -(Constants.PhotosTable.interitemSpacing * CGFloat(Constants.PhotosTable.countPhotos-1))                         
                                             )
            
        ])
    }
}


