//
//  User.swift
//  RedzExplorer
//
//  Created by homyt on 20/02/2025.
//

import Foundation

struct UserDto: Codable {
    let id: Int
    let userName: String
    let phoneNumber: String?
    let profileThumbnailURL: String?
    let email: String?
    let bio: String?
    let countryCode: String?
    let followedsCount: Int?
    let followingsCount: Int?
    let totalLikes: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "username"
        case phoneNumber = "phone_number"
        case profileThumbnailURL = "profile_thumbnail"
        case email
        case bio
        case countryCode = "country_code"
        case followedsCount = "followeds_count"
        case followingsCount = "followings_count"
        case totalLikes = "total_likes"
    }
}
