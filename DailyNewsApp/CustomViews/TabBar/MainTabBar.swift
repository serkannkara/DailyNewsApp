//
//  MainTabBar.swift
//  DailyNewsApp
//
//  Created by Serkan on 27.03.2022.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        UITabBar.appearance().tintColor = .systemGray
        viewControllers = [createNewsNC(),createSearchNC()]
    }
    
    func createSearchNC() -> UINavigationController {
        let searchNC = FavoritesVC()
        searchNC.title = "Favorites"
        searchNC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        
        return UINavigationController(rootViewController: searchNC)
    }
    
    func createNewsNC() -> UINavigationController {
        let newsNC = NewsViewController()
        newsNC.title = "News App"
        newsNC.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        return UINavigationController(rootViewController: newsNC)
    }
}
