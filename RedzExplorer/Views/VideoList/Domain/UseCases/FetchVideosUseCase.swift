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
    
    private let videoRepository: RepositoryProtocol
    
    init(videoRepository: RepositoryProtocol) {
        self.videoRepository = videoRepository
    }
    
    func execute(page: Int, searchQueries: [String]?, completion: @escaping (Result<[VideoDTO], Error>) -> Void) {
        videoRepository.call(page: page, searchQueries: searchQueries, completion: completion)
    }
}
