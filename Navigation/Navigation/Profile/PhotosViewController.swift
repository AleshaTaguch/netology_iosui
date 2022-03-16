import UIKit

class PhotosViewController: UIViewController{
    
    let photoArray: [String] = sourcePhotoArray

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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photo Gallary"
        self.view.backgroundColor = .systemGray6
        self.view.addSubviews(collectionView)
        
        activateConstraints()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self),
                                                            for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setCellFromDataSet(photoArray[indexPath.row])
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
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
