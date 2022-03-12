import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    static let classIdentifier: String = "PhotoTableViewCell"
    
    let stackView : UIStackView = {
        let photoStackView = UIStackView()
        photoStackView.axis = .horizontal
        photoStackView.spacing = 8
        photoStackView.distribution = .fillEqually
        //photoStackView.backgroundColor = .magenta
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
        let photoImageView = UIImageView()
        photoImageView.image = UIImage(systemName: "arrow.right")
        photoImageView.tintColor = .black
        photoImageView.toAutoLayout()
        return photoImageView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        for num in 1...4 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "foto2-\(num)")
            imageView.layer.cornerRadius = 6
            imageView.layer.masksToBounds = true
            //imageView.layer.borderWidth = 0.5
            //imageView.layer.borderColor = UIColor.black.cgColor
            imageView.contentMode = .scaleToFill // .scaleAspectFit
            imageView.backgroundColor = .red
            
            stackView.addArrangedSubview(imageView)
            //imageView.toAutoLayout()
        }

        contentView.addSubviews(titleLabel,titleImage,stackView)
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

extension PhotoTableViewCell {
    
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            
            titleImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            titleImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            //titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            //titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            titleImage.widthAnchor.constraint(equalTo: titleLabel.heightAnchor),
            titleImage.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            stackView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.25, constant: -12-12+8)
        ])
    }
}
