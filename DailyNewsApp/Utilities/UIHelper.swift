//
//  UIHelper.swift
//  DailyNewsApp
//
//  Created by Serkan on 25.03.2022.
//

import UIKit

struct UIHelper {
    static func collectionViewFlowLayout(in view: UIView) -> UICollectionViewFlowLayout{
        
            let flowLayout                  = UICollectionViewFlowLayout()
            let width                       = view.bounds.width
            let padding: CGFloat            = 5
            let minimumItemSpacing: CGFloat = 5
            let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
            let itemWidth                   = availableWidth / 2
            flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
            flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth*1.3)
            return flowLayout
    }
}
