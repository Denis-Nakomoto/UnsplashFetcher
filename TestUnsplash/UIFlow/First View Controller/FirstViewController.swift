//
//  FirstViewController.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 06.06.2022.
//

import UIKit

enum Section: Int, CaseIterable {
    case mySection
}

class FirstViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.register(FirstVCItem.self, forCellWithReuseIdentifier: FirstVCItem.reuseId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        return collectionView
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource <Section, Photo>?
    
    var coordinator: FirstVCFlow?
    
    var photos: [Photo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        createDataSource()
        setupSearchBar()
        loadPhotos()
    }
    
    private func setupConstraints() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 10)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .estimated(200))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 10)
            return section
        }
        return layout
    }
    
    private func setupSearchBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func loadPhotos() {
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            NetworkService.getListPictures(with: ApiRequests.photos.rawValue) { [weak self] (result: [Photo]?, error) in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.photos = result
                    self.reloadData()
                }
            }
        }
    }
}

//MARK: - Data source
extension FirstViewController {
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Photo>(collectionView: collectionView,
                                                                        cellProvider: { [weak self] (collectionView,
                                                                        indexPath, photo) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            
            guard let self = self else { return UICollectionViewCell() }
            
            switch section {
            case .mySection:
                guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: FirstVCItem.reuseId, for: indexPath) as? FirstVCItem
                else { fatalError() }
                item.setPicture(with: self.photos?[indexPath.row].urls?.small ?? "")
                return item
            }
        })
    }
    
    private func reloadData() {
            var snapshot = NSDiffableDataSourceSnapshot<Section, Photo>()
            snapshot.appendSections([.mySection])
            snapshot.appendItems(photos ?? [], toSection: .mySection)
            dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Delegate
extension FirstViewController: UICollectionViewDelegate {
    
}

//MARK: - SearchBarDelegate
extension FirstViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            NetworkService.getListPictures(with: ApiRequests.searchRequest.rawValue,
                                           query: searchText) { [weak self] (result: SearchResult?, error) in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.photos = result?.results
                    self.reloadData()
                }
            }
        } else {
            self.loadPhotos()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadPhotos()
    }
}

