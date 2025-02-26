//
//  DateFormater.swift
//  RedzExplorer
//
//  Created by homyt on 23/02/2025.
//

import Foundation

class DateFormatterUtil {
    
    // Method to conver date into "yyyy-MM-dd" format
    static func formatDate(inputDateString: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        
        // Convert string to Date
        if let date = inputFormatter.date(from: inputDateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy-MM-dd"
            
            return outputFormatter.string(from: date)
        }
        
        // Return nil if input invalid
        return nil
    }
}
