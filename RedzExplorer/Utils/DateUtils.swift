//
//  DateUtils.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

import Foundation

extension Date {
    
    func toString(withFormat format: String = "yyyy-MM-dd") -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format
        return dateFormater.string(from: self)
    }
}
