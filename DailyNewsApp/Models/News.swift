//
//  News.swift
//  DailyNewsApp
//
//  Created by Serkan on 24.03.2022.
//

import Foundation
import SwiftUI
import CoreData


public struct News: Codable, Hashable {
    public let articles: [Articles]
}

public struct Articles: Codable, Hashable{
    public let title: String?
    public let urlToImage: String?
    public let description: String?
    public let url: String?
    public let publishedAt: String?
}
