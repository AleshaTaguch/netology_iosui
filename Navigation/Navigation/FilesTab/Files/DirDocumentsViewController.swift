import UIKit

final class DirDocumentsViewController: UIViewController {
    
    weak var coordinatorDeligate: FilesCoordinatorProtocol?
    
    var fileArray: [String] = []
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = true
        tableView.separatorInset = .zero
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .systemGray6
        tableView.toAutoLayout()
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Dir Documents"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain ,target: self, action: #selector(addPhotoFromGelary))
        
        view.addSubviews(tableView)
        
        activateConstraints()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(DirDocumentsTableViewCell.self, forCellReuseIdentifier: DirDocumentsTableViewCell.classIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshDirDocuments()
    }
    
    func refreshDirDocuments() {
        self.fileArray.removeAll()
        
        let fileManager = FileManager.default
        do {
            let documentDirectoryUrl = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            let contentDocumentDirectory = try fileManager.contentsOfDirectory(at: documentDirectoryUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for elementContent in contentDocumentDirectory {
                self.fileArray.append(elementContent.lastPathComponent)
            }
            if UserDefaults.standard.bool(forKey: SettingsKey.sortFileKey) {
                fileArray.sort(by: { $0 > $1 })
            } else {
                fileArray.sort(by: { $0 < $1 })
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        self.tableView.reloadData()
        
    }
    
    func createPhotoToDirectory(imageFileName: String, imageData: Data, complition: (()->Void)) {
        let fileManager = FileManager.default
        do {
            let documentDirectoryUrl = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            let imagePathURL = documentDirectoryUrl.appendingPathComponent(imageFileName)
            if fileManager.createFile(atPath: imagePathURL.path, contents: imageData ) {
                complition()
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deletePhotoFromDirectory(imageFileName: String, complition: (()->Void) ) {
        let fileManager = FileManager.default
        do {
            let documentDirectoryUrl = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            let imagePathURL = documentDirectoryUrl.appendingPathComponent(imageFileName)
            try fileManager.removeItem(at: imagePathURL)
            complition()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func addPhotoFromGelary () {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.mediaTypes = ["public.image"]
        
        navigationController?.present(imagePickerController, animated: true, completion: nil)
    }
    
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}


extension DirDocumentsViewController: UITableViewDataSource ,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DirDocumentsTableViewCell.classIdentifier, for: indexPath) as! DirDocumentsTableViewCell
        cell.setCellFromDataSet(fileArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileArray.count
    
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            self.deletePhotoFromDirectory(imageFileName: self.fileArray[indexPath.row]) {
                self.refreshDirDocuments()
            }
            
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
      
}

extension DirDocumentsViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard let imageUrl = info[.imageURL] as? NSURL else { return }
        guard let imageFileName = imageUrl.lastPathComponent else {return}
        
        guard let image = info[.editedImage] as? UIImage else { return }
        guard let imageData = image.jpegData(compressionQuality: 1.0)  else { return }
        
        createPhotoToDirectory(imageFileName: imageFileName, imageData: imageData) {
            self.refreshDirDocuments()
        }
        
        picker.dismiss(animated: true, completion: nil)
       
    }
}


