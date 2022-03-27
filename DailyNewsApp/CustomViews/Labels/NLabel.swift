//
//  NLabel.swift
//  DailyNewsApp
//
//  Created by Serkan on 24.03.2022.
//

import UIKit

class NLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat){
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize,weight: .medium)
        configure()
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        textColor = .label
        adjustsFontSizeToFitWidth   = true
        
    }
}
