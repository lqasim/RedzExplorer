//
//  StringUtils.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

import Foundation

extension String {
    
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'") -> Date?{
        let formater = DateFormatter()
        formater.dateFormat = format
        
        return formater.date(from: self)
    }
}
