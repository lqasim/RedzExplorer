//
//  VideoListFactory.swift
//  RedzExplorer
//
//  Created by homyt on 26/02/2025.
//

import Foundation
import XCoordinator

class VideoListFactory {
    
    static func create(router: WeakRouter<AppRoute>) -> VideoListViewModel {
        return VideoListViewModel(useCase: createUseCase(), videoMapper: createMapper(),router: router)
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
