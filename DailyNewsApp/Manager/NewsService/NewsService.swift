//
//  NewsService.swift
//  DailyNewsApp
//
//  Created by Serkan on 24.03.2022.
//

import Foundation
import UIKit


protocol NewsNetworkServiceProtocol {
    func fetchNews(completion: @escaping (Result<[Articles], NError>) -> Void)
}

struct NewsService: NewsNetworkServiceProtocol {
    
    static let shared = NewsService()
    let cache = NSCache<NSString, UIImage>()
    
    let news = [Articles]()
    func fetchNews(completion: @escaping (Result<[Articles], NError>) -> Void) {
        let urlString = "\(Constrants.baseURL)/v2/top-headlines?country=tr&category=sports&apiKey=\(Constrants.apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidComplete))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.invalidComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do{
                
                let news = try JSONDecoder().decode(News.self, from: data)
                completion(.success(news.articles))
            }catch{
                completion(.failure(.invalidComplete))
            }

        }.resume()
    }
}
