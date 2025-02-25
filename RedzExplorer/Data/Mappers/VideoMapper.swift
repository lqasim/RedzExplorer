//
//  VideoMapper.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

import Foundation

// Mapper to convert DTOs to Domain Models
class VideoMapper {
    func map(dto: VideoDTO) -> Video {
        return Video(
            id: dto.id,
            description: dto.description ?? "No description available",
            category: dto.category ?? "No Available Category",
            image: PostImage(url: dto.image?.url ?? ""),
            postThumbnailImageURL: dto.postThumbnailImageURL ?? "",
            totalLikesCount: dto.totalLikesCount ?? 0,
            totalViewsCount: dto.totalViewsCount ?? 0,
            totalCommentsCount: dto.totalCommentsCount ?? 0,
            user: User(
                id: dto.user.id,
                userName: dto.user.userName,
                phoneNumber: dto.user.phoneNumber ?? "No Number",
                profileThumbnailURL: dto.user.profileThumbnailURL ?? "https://as2.ftcdn.net/v2/jpg/10/74/24/47/1000_F_1074244751_oiRCQr1irAIftqs4Gb7fbjwPthw4cbN3.jpg",
                email: dto.user.email ?? "",
                bio: dto.user.bio ?? "No bio",
                countryCode: dto.user.countryCode ?? "",
                followedsCount: dto.user.followedsCount ?? 0,
                followingsCount: dto.user.followingsCount ?? 0,
                totalLikes: dto.user.totalLikes ?? 0
            ),
            postCategory: dto.postCategory ?? [],
            publishedAt: dto.publishedAt ?? ""
        )
    }
}

class PostMapper {
    func map(dto: PostDTO) -> [Video] {
        return dto.posts.map { VideoMapper().map(dto: $0) }
    }
}
