//
//  Categories.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

import Foundation

enum Category: String, CaseIterable {
    case all
    case recent
    case nearest
    case following
    case topRaising
    case recommended
    case popularTrending
    
    var displayName: String {
        switch self {
        case .all: return "All"
        case .recent: return "RECENT"
        case .nearest: return "NEAREST"
        case .following: return "FOLLOWING"
        case .topRaising: return "TOP_RAISING"
        case .recommended: return "RECOMMENDED"
        case .popularTrending: return "POPULAR_TRENDING"
        }
    }
}
