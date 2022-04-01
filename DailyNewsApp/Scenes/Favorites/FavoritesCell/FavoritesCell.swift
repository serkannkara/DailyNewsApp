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

        // Configure the view for the selected state
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
        
        NSLayoutConstraint.activate([
            favoriteCellImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            favoriteCellImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            favoriteCellImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            favoriteCellImage.widthAnchor.constraint(equalTo: favoriteCellImage.heightAnchor),
            
            favoriteCellLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            favoriteCellLabel.leadingAnchor.constraint(equalTo: favoriteCellImage.trailingAnchor, constant: 10),
            favoriteCellLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            favoriteCellLabel.heightAnchor.constraint(equalToConstant: 50),
            
            favoriteCellDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            favoriteCellDateLabel.leadingAnchor.constraint(equalTo: favoriteCellImage.leadingAnchor, constant: 10),
            favoriteCellDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            favoriteCellDateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
    }

}
