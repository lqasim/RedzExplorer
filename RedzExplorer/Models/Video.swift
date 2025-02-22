//
//  Video.swift
//  RedzExplorer
//
//  Created by homyt on 19/02/2025.
//

import Foundation

struct Video: Codable {
    let id: Int
    let description: String?
    let category: String?
    let image: PostImage?
    let postThumbnailImageURL: String?
//    let videoURL: String?
    let totalLikesCount: Int?
    let totalViewsCount: Int?
    let totalCommentsCount: Int?
    let user: User
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
//        case videoURL = "video.url"
    }
}

struct PostImage: Codable {
    let url: String
}

struct Post: Codable {
    let posts: [Video]
    
    enum CodingKeys: String, CodingKey {
        case posts
    }
}


struct VideoResponse: Codable {
    let data: Post
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}



