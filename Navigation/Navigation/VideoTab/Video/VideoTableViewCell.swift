import UIKit
import StorageService

class VideoTableViewCell: UITableViewCell {
    
    static let classIdentifier: String = "VideoTableViewCell"
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.toAutoLayout()
        return titleLabel
    }()
    
    let urlLabel: UILabel = {
        let urlLabel = UILabel()
        urlLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        urlLabel.textColor = .darkGray
        urlLabel.numberOfLines = 1
        urlLabel.toAutoLayout()
        return urlLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(titleLabel,
                                urlLabel)
        
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
    
    public func setCellFromDataSet(_ videoSource: VideoSource) {
        self.titleLabel.text = videoSource.title
        self.urlLabel.text = videoSource.url
    }
    
    private func activateConstraints () {
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width).inset(16)
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top).inset(8)
        }
        
        urlLabel.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width).inset(16)
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.equalTo(contentView.snp.bottom).inset(8)
        }

    }
}
