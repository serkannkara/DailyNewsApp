//
//  DataPersistanceManager.swift
//  DailyNewsApp
//
//  Created by Serkan on 26.03.2022.
//

import Foundation
import UIKit
import CoreData

protocol DataPersistanceManagerProtocol{
    func downloadTitleWith(model: Articles, completion: @escaping (Result<Void, Error>) -> Void)
    func fetchingFavoritesFromDataBase(completion: @escaping (Result<[TitleItem], Error>) -> Void)
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void)
}


struct DataPersistanceManager: DataPersistanceManagerProtocol {
    
    static let shared = DataPersistanceManager()
    
    func downloadTitleWith(model: Articles, completion: @escaping (Result<Void, Error>) -> Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        
        item.title = model.title
        item.publishedAt = model.publishedAt
        item.urlToImage = model.urlToImage
        item.urll = model.url
        item.descriptionn = model.description
        
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    func fetchingFavoritesFromDataBase(completion: @escaping (Result<[TitleItem], Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>

        request = TitleItem.fetchRequest()

        do{
            let titles = try context.fetch(request)
            completion(.success(titles))
        }catch{
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        context.delete(model)
        
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(DatabaseError.failedToDeletaData))
        }
    }
}
