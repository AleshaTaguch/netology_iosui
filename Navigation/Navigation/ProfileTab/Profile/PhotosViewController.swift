import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController{
    
    var photoImageReciveArray: [UIImage] = [] {
        didSet {
            self.title = "Photo Gallary [\(photoImageReciveArray.count)]"
        }
    }
    
    let imagePublisherFacade = ImagePublisherFacade()
    
    //аттрибуты для таймера
    var timerReloadData: Timer?
    var counterTimerReloadData: Int = 0 {
        didSet {
            commentTextView.text = "Reload after \(counterTimerReloadData) sec"
            commentTextView.isHidden = !(counterTimerReloadData>0)
        }
    }
    
    // UI элементы
    
    lazy var layuot: UICollectionViewFlowLayout = {
        let layuot = UICollectionViewFlowLayout()
        layuot.sectionInset = UIEdgeInsets(top: Constants.PhotosCollection.topMargin,
                                           left: Constants.PhotosCollection.leftMargin,
                                           bottom: Constants.PhotosCollection.buttomMargin,
                                           right: Constants.PhotosCollection.rightMargin)
        layuot.minimumLineSpacing = Constants.PhotosCollection.lineSpacing
        layuot.minimumInteritemSpacing = Constants.PhotosCollection.interitemSpacing
        layuot.scrollDirection = .vertical
        return layuot
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layuot)
        collectionView.toAutoLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        
        return collectionView
    }()
    
    let commentTextView: UITextView = {
        let commentTextView = UITextView()
        commentTextView.font = UIFont.boldSystemFont(ofSize: 18)
        commentTextView.textColor = .darkGray
        commentTextView.backgroundColor = .white
        commentTextView.alpha = 0.7
        commentTextView.toAutoLayout()
        commentTextView.text = "тут будет таймер"
        commentTextView.textAlignment = .center
        commentTextView.isHidden = true
        return commentTextView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photo Gallary"
        self.view.backgroundColor = .systemGray6
        self.view.addSubviews(collectionView,commentTextView)
        
        activateConstraints()
        //обрабатываем массив фоток в backgraund потоке и подписывваемся на его обновления
        doSubscribeOnProcessedArray()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //Отменяем подписку
        doRemoveSubscribe()
        
        //Удаляем таймер
        doDeactivateReloadDataTimer()
    }
    
    func doActivateReloadDataTimer() {
        //Удаляем таймер, если был
        doDeactivateReloadDataTimer()
        
        // запускаем новый таймер
        counterTimerReloadData = Constants.PhotosCollection.reloadTimerInterval
        timerReloadData = Timer.scheduledTimer(withTimeInterval: 1.0,
                                               repeats: true,
                                               block: { myTimer in
            self.counterTimerReloadData -= 1
            if self.counterTimerReloadData <= 0 {
                self.doDeactivateReloadDataTimer()
                self.photoImageReciveArray.removeAll()
                self.collectionView.reloadData()
                self.doSubscribeOnProcessedArray()
            }
        })

    }
    
    func doDeactivateReloadDataTimer() {
        counterTimerReloadData = 0
        if let valueTimer = timerReloadData {
            valueTimer.invalidate()
            timerReloadData = nil
        }
    }
    
    func doRemoveSubscribe() {
        imagePublisherFacade.removeSubscription(for: self)
        imagePublisherFacade.rechargeImageLibrary()
    }
    
    func doSubscribeOnProcessedArray() {
        let colorFilter: ColorFilter = {
            guard let colorFilter = ColorFilter.allCases.randomElement() else {
                return .chrome
            }
            return colorFilter
        }()
        var startTime: UInt64 = 0
        var finishTime: UInt64 = 0
        startTime = DispatchTime.now().uptimeNanoseconds
        ImageProcessor().processImagesOnThread(sourceImages: sourcePhotoImageArray,
                                               filter: colorFilter,
                                               qos: .background) { arrayCGImage in
            var arrayUIImage: [UIImage] = []
            arrayCGImage.forEach{
                if let imageCG = $0 {
                    arrayUIImage.append(UIImage(cgImage: imageCG))
                }
            }
            finishTime = DispatchTime.now().uptimeNanoseconds
            DispatchQueue.main.async{
                //подписываемся на получение сообщенй
                self.imagePublisherFacade.subscribe(self)
                //запускаем таймер с публикацией картинок
                self.imagePublisherFacade.addImagesWithTimer(time: 0.1,
                                                             repeat: Constants.PhotosCollection.countPhotosCollectionMax,
                                                             userImages: arrayUIImage )
                //печать длительности времени выполнения
                let elepsedTimePerSecond = Double(finishTime - startTime) / 1000000000
                print("processImagesOnThread - filter \(colorFilter), execution time \(elepsedTimePerSecond) sec")
            }
        }
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoImageReciveArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self),
                                                            for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setCellFromDataSet(photoImageReciveArray[indexPath.row])
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPhoto: CGFloat = floor((collectionView.frame.width
                                         - Constants.PhotosCollection.interitemSpacing * CGFloat(Constants.PhotosCollection.countColumns - 1 )
                                         - Constants.PhotosCollection.rightMargin
                                         - Constants.PhotosCollection.leftMargin) / CGFloat(Constants.PhotosCollection.countColumns))
        
        return CGSize(width: widthPhoto, height: widthPhoto)
    }
}

extension PhotosViewController {
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            commentTextView.topAnchor.constraint(equalTo: collectionView.topAnchor),
            commentTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 6),
            commentTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -6),
            commentTextView.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}

//получение картинок от publisher-a
extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        photoImageReciveArray = images
        collectionView.reloadData()
        
        if photoImageReciveArray.count >= Constants.PhotosCollection.countPhotosCollectionMax {
            //Отменяем подписку
            doRemoveSubscribe()
            //запускаем таймер на обновление
            doActivateReloadDataTimer()
        }
    }
}

