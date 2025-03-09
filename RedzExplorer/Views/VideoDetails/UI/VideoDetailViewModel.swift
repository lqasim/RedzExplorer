//
//  VideoDetailViewModel.swift
//  RedzExplorer
//
//  Created by homyt on 09/03/2025.
//

import Foundation
import SwiftUI

class VideoDetailViewModel: ObservableObject {
    @Published var video: Video
    @Published var isLiked: Bool = false
    @Published var likeCount: Int = 0
    
    private let persistenceService: UserPersistence
    private let videoId: Int
    
    // TODO: - Remove Default persistance and move it to di
    init(video: Video, persistenceService: UserPersistence = UserDefaultsManager()) {
        self.video = video
        self.persistenceService = persistenceService
        self.videoId = video.id
        self.isLiked = self.persistenceService.retrieve(forKey: .likedVideoKey, as: Int.self)?.contains(video.id) ?? false
        self.likeCount = self.calculateLikeCount()
    }
    
    func calculateLikeCount() -> Int {
        var currentLikeCount = video.totalLikesCount
        if isLiked {
            currentLikeCount += 1
        }
        return currentLikeCount
    }
    
    func toggleLike() {
        isLiked.toggle()
        if isLiked {
            likeCount += 1
            persistenceService.save(video.id, forKey: .likedVideoKey)
        } else {
            likeCount -= 1
            persistenceService.remove(video.id, forKey: .likedVideoKey)
        }
    }
}
