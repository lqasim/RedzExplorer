//
//  FetchVideosUseCase.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

import Foundation

protocol FetchVideosUseCaseProtocol {
    func execute(page: Int, searchQueries: [String]?, completion: @escaping (Result<[VideoDTO], Error>) -> Void)
}

class FetchVideosUseCase: FetchVideosUseCaseProtocol {
    
    private let videoRepository: VideoRepositoryProtocol
    
    init(videoRepository: VideoRepositoryProtocol = VideoRepository()) {
        self.videoRepository = videoRepository
    }
    
    func execute(page: Int, searchQueries: [String]?, completion: @escaping (Result<[VideoDTO], Error>) -> Void) {
        videoRepository.fetchVideos(page: page, searchQueries: searchQueries, completion: completion)
    }
}
