import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        return imageView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        contentView.backgroundColor = .white
        contentView.addSubviews(imageView)
        
        activateConstraints()
            
    }
    
    required init?(coder: NSCoder) { 
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PhotosCollectionViewCell {
    
    public func setCellFromDataSet(_ namePhoto: String) {
        self.imageView.image = UIImage(named: namePhoto)
    }

}

extension PhotosCollectionViewCell {
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
