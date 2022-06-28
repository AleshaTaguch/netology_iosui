import UIKit

protocol VideoPlayerDeligare: AnyObject {
    func play(urlString: String)
}

class VideoView: UIView {

    let videoArray: [VideoSource] = videoSourceArray
    
    weak var videoPlayerDeligare: VideoPlayerDeligare?
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = true
        tableView.separatorInset = .zero
        tableView.separatorStyle = .singleLine
        tableView.rowHeight =  UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.backgroundColor = .systemGray6
        tableView.toAutoLayout()
        return tableView
    }()

    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        self.addSubviews(tableView)

        activateConstraints()
        
        tableView.dataSource = self
        tableView.delegate = self
    
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: VideoTableViewCell.classIdentifier)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func activateConstraints () {
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }

}


extension VideoView: UITableViewDataSource ,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.classIdentifier,
                                                 for: indexPath) as! VideoTableViewCell
        cell.setCellFromDataSet(videoArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        
        if let valueVideoPlayerDeligare = videoPlayerDeligare {
            valueVideoPlayerDeligare.play(urlString: videoArray[indexPath.row].url)
        }
    }
      
}
