import UIKit

class InfoViewController: UIViewController {
    
    weak var coordinatorDeligate: FeedCoordinatorProtocol?
    
    var peopleArray: [String] = []
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        nameLabel.backgroundColor = .white
        nameLabel.toAutoLayout()
        return nameLabel
    }()
    
    let periodLabel: UILabel = {
        let periodLabel = UILabel()
        periodLabel.font = UIFont.systemFont(ofSize: 18)
        periodLabel.backgroundColor = .white
        periodLabel.toAutoLayout()
        return periodLabel
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = true
        tableView.separatorInset = .zero
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.backgroundColor = .white
        tableView.toAutoLayout()
        
        return tableView
    }()
    
    lazy var button: CustomButton = CustomButton(frame: .zero, title: "Go Alert") { self.showAlert() }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 225.0/255.0, green: 215.0/255.0, blue: 200.0/255.0, alpha: 1)
        self.title = "Info"
        
        self.view.addSubviews(button,
                              nameLabel,
                              periodLabel,
                              tableView)
        
        activateConstraints()
        
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.classIdentifier)
        
        
       
        NetworkManager.URLSessionDataTask(appConfig: AppConfiguration.user) { typeDataExtract, arrayString in
            if typeDataExtract == .title {
                DispatchQueue.main.async {
                    self.nameLabel.text = arrayString.first
                }
            }
        }
 
        NetworkManager.URLSessionDataTask(appConfig: AppConfiguration.planet) { typeDataExtract, arrayString in
            switch typeDataExtract {
            case .rotationPeriod:
                DispatchQueue.main.async {
                    self.periodLabel.text = arrayString.first
                }
            case .residents:
                self.peopleArray.removeAll()
                arrayString.forEach{
                    NetworkManager.URLSessionDataTask(appConfig: AppConfiguration.resident(url: $0)) { typeDataExtract, arrayString in
                        if typeDataExtract == .name,  let peopleName = arrayString.first {
                            self.peopleArray.append(peopleName)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            default:
                print("")
            }

        }
        
    }
}

extension InfoViewController {

    @objc func showAlert() {
        let alertViewController = UIAlertController(title: "Title Alert", message: "Very long message", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Yes", style: .default, handler: (printAlertResult))
        let actionNo = UIAlertAction(title: "No", style: .cancel, handler: (printAlertResult))
        
        alertViewController.addAction(actionYes)
        alertViewController.addAction(actionNo)
        
        self.present(alertViewController, animated: true, completion: nil)
        
    }
    
    func printAlertResult(_ alertAction: UIAlertAction) {
        if let alertButton = alertAction.title {
            print("The \(alertButton) button was pressed.")
        } else {
            print("Button was pressed.")
        }
    }
    
}

extension InfoViewController {
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            periodLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 16),
            periodLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            periodLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -16),
            periodLabel.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: self.periodLabel.bottomAnchor, constant: 16),
            tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: self.button.topAnchor, constant: -16),
            
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6, constant: 0),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            
            
        ])
    }
}


extension InfoViewController: UITableViewDataSource ,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.classIdentifier, for: indexPath) as! InfoTableViewCell
            cell.setCellFromDataSet(peopleArray[indexPath.row])
            return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
      
}

