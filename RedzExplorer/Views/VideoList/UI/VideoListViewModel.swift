//
//  VideoListViewModel.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

import Foundation
import XCoordinator

enum LoadingState<T: Decodable>: Equatable {
    
    case idle
    case loading
    case loaded(_ result: Result<T, Error>)
    
    static func == (lhs: LoadingState<T>, rhs: LoadingState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading), (.loaded(_), .loaded(_)):
            return true
        default:
            return false
        }
    }
}

class VideoListViewModel {
    
    var didUpdateLoadingState: ((LoadingState<[Video]>) -> ())?
    
    var loadingState: LoadingState<[Video]> = .idle {
        didSet {
            didUpdateLoadingState?(loadingState)
        }
    }
    
    private(set) var videos = [Video]()
    private var currentPage = 1
    
    private let useCase: FetchVideosUseCaseProtocol
    private let videoMapper: VideoMapper
    
    // router
    var appRouter: WeakRouter<AppRoute>
    
    init(useCase: FetchVideosUseCaseProtocol, videoMapper: VideoMapper, router: WeakRouter<AppRoute>) {
        self.useCase = useCase
        self.videoMapper = videoMapper
        self.appRouter = router
    }
    
    func loadMoreVideos(searchQueries: [String]?) {
        self.currentPage += 1
        
        self.loadVideos(searchQueries: searchQueries)
    }
    
    func showVideoDetails(_ post: Video) {
        self.appRouter.trigger(.videoDetails(post))
    }
    
    func loadVideos(searchQueries: [String]?) {
        guard loadingState != .loading
        else { return }
        
        loadingState = .loading
        
        useCase.execute(page: self.currentPage, searchQueries: searchQueries) { [weak self] (result: Result<VideoDTOAPIResponse,Error>) in
            guard let self = self
            else { return }
            
            switch result {
            case .success(let data):
                
                let mappedVideos = data.data.posts.compactMap {
                    self.videoMapper.map(dto: $0)
                }
                
                self.videos.append(contentsOf: mappedVideos)

                loadingState = .loaded(.success(self.videos))
            case .failure(let error):
                loadingState = .loaded(.failure(error))
            }
            
            loadingState = .idle
         }
    }
}
