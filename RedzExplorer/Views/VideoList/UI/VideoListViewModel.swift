//
//  VideoListViewModel.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

import Foundation
import XCoordinator

class VideoListViewModel {
    
    var didFetchVideos: (() -> Void)?
    var didFailWithError: ((String) -> Void)?
    
    private(set) var videos = [Video]()
    
    private var isLoading = false
    private var currentPage = 1
    private var searchQueries: [String]?
    private var appendable = true
    
    private let useCase: FetchVideosUseCaseProtocol
    private let videoMapper: VideoMapper
    
    private var requestQueue: [(() -> Void)] = []
    // router
    var appRouter: WeakRouter<AppRoute>
    
    init(useCase: FetchVideosUseCaseProtocol, videoMapper: VideoMapper, router: WeakRouter<AppRoute>) {
        self.useCase = useCase
        self.videoMapper = videoMapper
        self.appRouter = router
    }
    
    public func retrieveVideos(searchQueries: [String]?, completion: @escaping() -> Void) {
        requestQueue.append {
            self.loadVideos(searchQueries: searchQueries, completion: completion)
        }
        
        // Start processing if no other requests are being handled
        if !isLoading {
            processNextRequest()
        }
    }
    
    private func processNextRequest() {
        if !requestQueue.isEmpty {
            let nextRequest = requestQueue.removeFirst()
            nextRequest()
        }
    }
    
    func showVideoDetails(_ post: Video) {
        self.appRouter.trigger(.videoDetails(post))
    }
    
    private func loadVideos(searchQueries: [String]?, completion: @escaping() -> Void) {
        guard !isLoading else { return }
        
        isLoading = true
        
        if self.searchQueries != searchQueries {
            self.searchQueries = searchQueries
            self.currentPage = 1
            self.appendable = false
        }
        
        useCase.execute(page: self.currentPage, searchQueries: searchQueries) { [weak self] (result: Result<[VideoDTO],Error>) in
            self?.isLoading = false
            switch result {
            case .success(let newVideos):
                let mappedVideos = newVideos.compactMap {
                    self?.videoMapper.map(dto: $0)
                }
                if self?.appendable == true {
                    self?.videos.append(contentsOf: mappedVideos)
                    self?.currentPage += 1
                } else {
                    self?.videos = mappedVideos
                    self?.appendable = true
                }
                self?.didFetchVideos?()
                completion()
            case .failure(let error):
                self?.didFailWithError?("Failed to fetch videos: \(error.localizedDescription)")
            }
            self?.processNextRequest()
        }
    }
}
