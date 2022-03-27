//
//  FavoritesVC.swift
//  DailyNewsApp
//
//  Created by Serkan on 24.03.2022.
//

import UIKit
import CoreData

class FavoritesVC: UIViewController {
    
    private var favorites: [TitleItem] = [TitleItem]()
    private var favoritess: TitleItem!
    
    private let favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseId)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        configureFavoritesTableView()
        fetchLocalStorageForDownload()
        Notify()
    }
    
    func configureNavBar(){
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    
    func Notify(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload()
        }
    }
    
    
    func configureFavoritesTableView(){
        view.addSubview(favoritesTableView)
        favoritesTableView.delegate     = self
        favoritesTableView.dataSource   = self
    }
    
    
    private func fetchLocalStorageForDownload(){
        DataPersistanceManager.shared.fetchingFavoritesFromDataBase { [weak self] result in
            switch result{
            case .success(let titles):
                self?.favorites = titles
                DispatchQueue.main.async { self?.favoritesTableView.reloadData() }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        favoritesTableView.frame = view.bounds
    }
}


extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseId, for: indexPath) as? FavoritesCell else {
            return UITableViewCell()
        }
        
        let favorite = favorites[indexPath.row]
        
        cell.set(news: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistanceManager.shared.deleteTitleWith(model: favorites[indexPath.row]) { result in
                switch result {
                case .success():
                    print("deleted from the database")
                case . failure(let error):
                    print(error.localizedDescription)
                }
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let new = favorites[indexPath.item]
        let destVC = NewsDetailVC()
        
        destVC.titleLabel.text              = new.title
        destVC.dateLabel.text               = new.publishedAt
        destVC.descriptionTextView.text     = new.descriptionn
        destVC.configureLearnMoreButton(name: new.urll ?? "")
        destVC.imageView.downloadImage(from: new.urlToImage ?? "")
        
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}
