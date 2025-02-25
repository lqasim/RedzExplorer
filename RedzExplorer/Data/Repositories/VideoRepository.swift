//
//  VideoRepository.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

import Foundation


protocol VideoRepositoryProtocol {
    func fetchVideos(page: Int, searchQueries: [String]?, completion: @escaping (Result<[VideoDTO], Error>) -> Void)
}

class VideoRepository: VideoRepositoryProtocol {
    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    func fetchVideos(page: Int, searchQueries: [String]?, completion: @escaping (Result<[VideoDTO], Error>) -> Void) {
        apiManager.fetchVideos(page: page, searchQueries: searchQueries, completion: completion)
    }
}
