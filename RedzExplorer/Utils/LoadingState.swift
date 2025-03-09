//
//  LoadingState.swift
//  RedzExplorer
//
//  Created by homyt on 09/03/2025.
//

import Foundation

enum LoadingState<T: Decodable>: Equatable {
    
    case idle
    case loading
    case loaded(_ result: Result<T, Error>)
    
    static func == (lhs: LoadingState<T>, rhs: LoadingState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading), (.loaded(_), .loaded(_)):
            return true
        default:
            return false
        }
    }
}
