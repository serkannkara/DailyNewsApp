//
//  Date+Ext.swift
//  DailyNewsApp
//
//  Created by Serkan on 1.04.2022.
//

import Foundation


extension Date {
    
    func convertToMonthYearFormat() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter.string(from: self)
    }
}
