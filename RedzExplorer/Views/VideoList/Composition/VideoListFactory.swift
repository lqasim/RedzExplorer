//
//  VideoListFactory.swift
//  RedzExplorer
//
//  Created by homyt on 26/02/2025.
//

import Foundation

class VideoListFactory {
    
    static func create() -> VideoListViewModel {
        return VideoListViewModel(useCase: createUseCase(), videoMapper: createMapper())
    }
    private static func createMapper() -> VideoMapper {
        return VideoMapper()
    }
    
    private static func createUseCase() -> FetchVideosUseCaseProtocol {
        return FetchVideosUseCase(videoRepository: createRepository())
    }
    
    private static func createRepository() -> RepositoryProtocol {
        return VideoRepository(apiManager: createApiManager())
    }
    private static func createApiManager() -> APIManagerProtocol {
        return APIManager()
    }
}
