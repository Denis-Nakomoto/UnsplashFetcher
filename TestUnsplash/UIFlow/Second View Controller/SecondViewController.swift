//
//  SecondViewController.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 06.06.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    var coordinator: SecondVCFlow?
    
    var pictures: [Photo] = []
    
    var allFavorites: [CDPicture]? {
        didSet {
            downloadPictures()
        }
    }
    
    let group = DispatchGroup()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SecondViewCell.self, forCellReuseIdentifier: SecondViewCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFavorites()
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func loadFavorites() {
            self.allFavorites = StorageService.fetchAllFavorites()
    }
        
    private func downloadPictures() {
        pictures.removeAll()
            self.allFavorites?.forEach({ picture in
                group.enter()
                NetworkService.getPicture(with: picture.id ?? "") { [weak self] (result, error) in
                    guard let self = self else { return }
                    if let error = error {
                        DispatchQueue.main.async {
                            self.showAlert(with: "Info", and: "Something went wrong \(error)")
                        }
                        return
                    }
                    guard let result = result else { return }
                    self.pictures.append(result)
                    self.group.leave()
                }
            })
        self.group.notify(queue: .main) {
            self.pictures.removeDuplicates()
            self.tableView.reloadData()
        }

    }
}

// MARK: - UITableView Delegate
extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let picture = pictures[indexPath.row]
        coordinator?.coordinateToDetail(with: picture)
    }
}

extension SecondViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondViewCell.reuseId) as? SecondViewCell else {
            return SecondViewCell()
        }

        let photo = pictures[indexPath.row]
        cell.setupCell(with: photo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in

            let context = StorageService.viewContext
            let photo = self.pictures[indexPath.row]
                    let cdPicture = StorageService.getBy(id: photo.id ?? "")
                    if let cdPicture = cdPicture {
                        context.delete(cdPicture)
                        StorageService.shared.saveContext()
                    }
            self.pictures.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        delete.backgroundColor = .red
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = true
        return swipeActionConfig
    }
}


