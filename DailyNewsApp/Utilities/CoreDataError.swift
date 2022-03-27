//
//  CoreDataError.swift
//  DailyNewsApp
//
//  Created by Serkan on 27.03.2022.
//

import Foundation

enum DatabaseError: Error{
    case failedToSaveData
    case failedToFetchData
    case failedToDeletaData
}
