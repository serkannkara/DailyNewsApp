//
//  NewsCell.swift
//  DailyNewsApp
//
//  Created by Serkan on 24.03.2022.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    static let reuseId      = "cell"
    var news                = [Articles]()
    let newsCellImageView   = NImageView(frame: .zero)
    let newsCellLabel       = NLabel(fontSize: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(news: Articles){
        newsCellLabel.text = news.title
        newsCellImageView.downloadImage(from: news.urlToImage ?? "image")
    }
    
    private func configure(){
        addSubview(newsCellImageView)
        addSubview(newsCellLabel)
        
        newsCellImageView.translatesAutoresizingMaskIntoConstraints = false
        newsCellLabel.translatesAutoresizingMaskIntoConstraints = false
        newsCellLabel.numberOfLines  = 3
        let padding: CGFloat         = 5
        
        NSLayoutConstraint.activate([
            newsCellImageView.topAnchor.constraint(equalTo: topAnchor,constant: padding),
            newsCellImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding),
            newsCellImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -padding),
            newsCellImageView.heightAnchor.constraint(equalTo: newsCellImageView.widthAnchor),
            
            newsCellLabel.topAnchor.constraint(equalTo: newsCellImageView.bottomAnchor, constant: padding),
            newsCellLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding),
            newsCellLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -padding)
            
        ])
    }
}
