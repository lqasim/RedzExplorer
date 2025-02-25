//
//  Video.swift
//  RedzExplorer
//
//  Created by homyt on 19/02/2025.
//

import Foundation

struct VideoDTO: Codable {
    let id: Int
    let description: String?
    let category: String?
    let image: PostImageDTO?
    let postThumbnailImageURL: String?
    let totalLikesCount: Int?
    let totalViewsCount: Int?
    let totalCommentsCount: Int?
    let user: UserDto
    let postCategory: [String]?
    let publishedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case category
        case totalLikesCount = "total_likes_count"
        case totalViewsCount = "total_views_count"
        case totalCommentsCount = "total_comments_count"
        case user
        case postCategory = "post_category"
        case publishedAt = "published_at"
        case image
        case postThumbnailImageURL = "thumbnail_image"
    }
}

struct PostImageDTO: Codable {
    let url: String
}

struct PostDTO: Codable {
    let posts: [VideoDTO]
    
    enum CodingKeys: String, CodingKey {
        case posts
    }
}


struct VideoResponseDTO: Codable {
    let data: PostDTO
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}



