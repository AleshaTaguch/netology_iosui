import UIKit
import StorageService

class DirDocumentsTableViewCell: UITableViewCell {
    
    static let classIdentifier: String = "DirDocumentsTableViewCell"
    
    let fileNameLabel: UILabel = {
        let postTitleLabel = UILabel()
        postTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        postTitleLabel.textColor = .black
        postTitleLabel.numberOfLines = 2
        postTitleLabel.toAutoLayout()
        return postTitleLabel
    }()
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(fileNameLabel)
        
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
    
    public func setCellFromDataSet(_ fileName: String) {
        self.fileNameLabel.text = fileName
    }
    
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            fileNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            fileNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            fileNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            fileNameLabel.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant: -10)
        ])
    }
}
