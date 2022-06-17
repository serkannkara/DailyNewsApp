//
//  FavoritesCell.swift
//  DailyNewsApp
//
//  Created by Serkan on 26.03.2022.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    static let reuseId = "cell"
    
    var favoriteCellImage       = NImageView(frame: .zero)
    var favoriteCellLabel       = NLabel(fontSize: 20)
    var favoriteCellDateLabel   = NLabel(fontSize: 15)

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(news: TitleItem){
        favoriteCellLabel.text = news.title
        favoriteCellImage.downloadImage(from: news.urlToImage ?? "image")
        favoriteCellDateLabel.text = news.publishedAt?.convertToDisplayFormat()
        configure()
    }
    
    private func configure(){
        addSubview(favoriteCellImage)
        addSubview(favoriteCellLabel)
        addSubview(favoriteCellDateLabel)
        
        favoriteCellLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteCellImage.translatesAutoresizingMaskIntoConstraints = false
        favoriteCellDateLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteCellDateLabel.textAlignment = .right
        favoriteCellDateLabel.textColor = .systemGray
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            favoriteCellImage.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            favoriteCellImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            favoriteCellImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            favoriteCellImage.widthAnchor.constraint(equalTo: favoriteCellImage.heightAnchor),
            
            favoriteCellLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            favoriteCellLabel.leadingAnchor.constraint(equalTo: favoriteCellImage.trailingAnchor, constant: padding),
            favoriteCellLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            favoriteCellLabel.heightAnchor.constraint(equalToConstant: padding*5),
            
            favoriteCellDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            favoriteCellDateLabel.leadingAnchor.constraint(equalTo: favoriteCellImage.leadingAnchor, constant: padding),
            favoriteCellDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            favoriteCellDateLabel.heightAnchor.constraint(equalToConstant: padding*2)
        ])
        
        
    }

}
