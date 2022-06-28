import UIKit
import AVFoundation

class AudioView: UIView {

    //weak var deligate: FeedViewDeligateProtocol?
     
     private lazy var prevButton: UIButton = {
         let button = UIButton()
         button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
         button.addTarget(self, action: #selector(tapPrevButton), for: .touchUpInside)
         return button
     }()
     
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.addTarget(self, action: #selector(tapPlayButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.addTarget(self, action: #selector(tapStopButton), for: .touchUpInside)
        return button
    }()

    private lazy var pauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.addTarget(self, action: #selector(tapPauseButton), for: .touchUpInside)
        return button
    }()
    
    
    let buttonsSteckView: UIStackView = {
        let buttonsSteckView = UIStackView()
        buttonsSteckView.axis = .horizontal
        buttonsSteckView.spacing = 15
        buttonsSteckView.distribution = .fillEqually
        buttonsSteckView.toAutoLayout()
        buttonsSteckView.backgroundColor = .systemGray6
        buttonsSteckView.layer.cornerRadius = 5
        buttonsSteckView.layer.masksToBounds = true
        buttonsSteckView.layer.borderWidth = 0.5
        buttonsSteckView.layer.borderColor = UIColor.lightGray.cgColor
        buttonsSteckView.clipsToBounds = true
        return buttonsSteckView
    }()

    let progressPlayer: UIProgressView = {
        let progressPlayer = UIProgressView()
        progressPlayer.progress = 0.5
        return progressPlayer
    }()
    
    let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        timeLabel.textAlignment = .right
        timeLabel.toAutoLayout()
        return timeLabel
    }()
    
    let nameLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        timeLabel.toAutoLayout()
        return timeLabel
    }()
    
    var player: AVAudioPlayer  = AVAudioPlayer()
    var timerUpdate: Timer?
    let fileNameArray: [MusicFileName] = musicFileNameArray
    var currentFile: Int = 0 {
        didSet {
            if currentFile < 0 {
                currentFile = 0
            }
            if currentFile > fileNameArray.count-1 {
                currentFile = fileNameArray.count-1
            }
            preparePlayer()
        }
    }
    
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        self.addSubviews(buttonsSteckView,
                         timeLabel,
                         progressPlayer,
                         nameLabel)
        
        buttonsSteckView.addArrangedSubviews(prevButton,
                                             stopButton,
                                             playButton,
                                             pauseButton,
                                             nextButton)
        
        activateConstraints()

        preparePlayer()
        updatePlayerInfo()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func activateConstraints () {
        buttonsSteckView.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).inset(16)
            make.height.equalTo(40)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        
        progressPlayer.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).inset(16)
            make.height.equalTo(2)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(buttonsSteckView.snp.top).offset(-5)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.leading.equalTo(self.snp.leading).inset(16)
            make.trailing.equalTo(timeLabel.snp.leading)
            make.bottom.equalTo(progressPlayer.snp.top).offset(-5)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.leading.equalTo(nameLabel.snp.trailing)
            make.trailing.equalTo(self.snp.trailing).inset(16)
            make.bottom.equalTo(progressPlayer.snp.top).offset(-5)
        }
        
    }
    
    @objc func tapPrevButton() {
        currentFile -= 1
        tapPlayButton()
    }
    
    @objc func tapNextButton() {
        currentFile += 1
        tapPlayButton()
    }
    
    @objc func tapPlayButton() {
        player.play() 
        refreshTimer(status: true)
        updatePlayerInfo()
    }
    
    @objc func tapStopButton() {
        if player.isPlaying {
            player.stop()
            player.currentTime = 0
            refreshTimer(status: false)
            updatePlayerInfo()
        }
    }
    
    @objc func tapPauseButton() {
        if player.isPlaying {
            player.pause()
            refreshTimer(status: false)
            updatePlayerInfo()
        }
    }
    
    func preparePlayer() {
        
        do {
            guard let bundleFile = Bundle.main.path(forResource: fileNameArray[currentFile].name, ofType: fileNameArray[currentFile].ext) else { return }
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: bundleFile))
            player.delegate = self
            player.prepareToPlay()
        }
        catch {
            print(error)
        }
    }
    
    func refreshTimer(status: Bool) {
        if status {
            timerUpdate = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatePlayerInfo), userInfo: nil, repeats: true)
        }
        else {
            if let valueTimerUpdate = timerUpdate {
                valueTimerUpdate.invalidate()
                timerUpdate = nil
            }
        }
    }
    
    @objc func updatePlayerInfo() {
        
        let currentTime: Int = Int(player.currentTime)
        let currentTimeMinutes: Int = Int(currentTime / 60)
        let currentTimeSecond: Int = currentTime - currentTimeMinutes * 60
        
        let duration: Int = Int(player.duration)
        let durationMinutes: Int = Int(duration / 60)
        let durationSecond: Int = duration - durationMinutes * 60
        
        let progressTime: Float = round(Float(currentTime) / Float(duration) * 100) / 100
        progressPlayer.progress = progressTime

        timeLabel.text = String(format: "%02d:%02d / %02d:%02d",
                                currentTimeMinutes,
                                currentTimeSecond,
                                durationMinutes,
                                durationSecond) as String
        if let nameFile = player.url?.lastPathComponent {
            nameLabel.text = nameFile
        } else {
            nameLabel.text = ""
        }
            
    }
}


extension AudioView: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        refreshTimer(status: false)
        updatePlayerInfo()
    }
}
