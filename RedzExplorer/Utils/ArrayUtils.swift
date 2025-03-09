//
//  ArrayExtension.swift
//  RedzExplorer
//
//  Created by homyt on 09/03/2025.
//

import Foundation

// Helper to safely access elements of an array with index checking
extension Array {
    subscript(safe index: Int) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
        
    }
}
