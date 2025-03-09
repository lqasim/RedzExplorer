//
//  Video.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

import Foundation


struct Video: Decodable, Identifiable {
    let id: Int
    let description: String
    let category: String
    let image: PostImage
    let postThumbnailImageURL: String
    let totalLikesCount: Int
    let totalViewsCount: Int
    let totalCommentsCount: Int
    let user: User
    let postCategory: [String]
    let publishedAt: String
}
