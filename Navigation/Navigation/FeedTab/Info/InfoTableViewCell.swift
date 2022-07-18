import UIKit

class InfoTableViewCell: UITableViewCell {
    
    static let classIdentifier: String = "InfoTableViewCell"
    
    let peopleLabel: UILabel = {
        let postTitleLabel = UILabel()
        postTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        postTitleLabel.textColor = .black
        postTitleLabel.numberOfLines = 2
        postTitleLabel.toAutoLayout()
        return postTitleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(peopleLabel)
        
        activateConstraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setCellFromDataSet(_ peopleName: String) {
        self.peopleLabel.text = peopleName
    }

    private func activateConstraints () {
        NSLayoutConstraint.activate([
            peopleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            peopleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            peopleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            peopleLabel.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant: -16)
        ])
    }
    
}



    

