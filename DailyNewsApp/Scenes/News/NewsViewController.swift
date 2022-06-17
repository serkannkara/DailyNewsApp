//
//  ViewController.swift
//  DailyNewsApp
//
//  Created by Serkan on 24.03.2022.
//

import UIKit

class NewsViewController: UIViewController {
    
    enum Section { case main }
    var dataSource: UICollectionViewDiffableDataSource<Section, Articles>!
    var newsCollectionView: UICollectionView!
    
    private var news            = [Articles]()
    private var filteredNews    = [Articles]()    
    private var isSearching     = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configureCollectionView()
        cofigureDataSource()
        configureSearchController()
        getNews()
    }
    
    
    func configureCollectionView(){
        newsCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.collectionViewFlowLayout(in: view))
        view.addSubview(newsCollectionView)
        newsCollectionView.delegate = self
        newsCollectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.reuseId)
    }
    
    func getNews(){
        NewsService.shared.fetchNews { [weak self] news in
            guard let self = self else { return }
            switch news {
            case .success(let news):
                self.news.append(contentsOf: news)
                self.updateData(on: news)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func cofigureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Articles>(collectionView: newsCollectionView, cellProvider: { (collectionView, indexPath, news) -> UICollectionViewCell in
            let cell = self.newsCollectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.reuseId, for: indexPath) as! NewsCell
            cell.set(news: news)
            return cell
        })
    }
    
    
    func updateData(on news: [Articles]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Articles>()
        snapshot.appendSections([.main])
        snapshot.appendItems(news)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true)}
    }
    
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    private func downloadTitleAt(indexPath: IndexPath){
        DataPersistanceManager.shared.downloadTitleWith(model: news[indexPath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension NewsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray     = isSearching ? filteredNews : news
        let new             = activeArray[indexPath.item]
        let destVC          = NewsDetailVC()
        
        destVC.titleLabel.text          = new.title
        destVC.dateLabel.text           = new.publishedAt?.convertToDisplayFormat()
        destVC.descriptionTextView.text = new.description
        destVC.configureLearnMoreButton(name: new.url ?? "")
        destVC.imageView.downloadImage(from: new.urlToImage ?? "")
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) {[weak self] _ in
                let downloadAction = UIAction(title: "Favorites", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                    self?.downloadTitleAt(indexPath: indexPath)
                }
                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
            }
        
        return config
    }
}


extension NewsViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredNews = news.filter{ $0.title!.lowercased().contains(filter.lowercased())}
        updateData(on: filteredNews)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: news)
    }
}
