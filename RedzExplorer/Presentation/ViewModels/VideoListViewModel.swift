//
//  VideoListViewModel.swift
//  RedzExplorer
//
//  Created by homyt on 25/02/2025.
//

import Foundation

class VideoListViewModel {
    
    var didFetchVideos: (() -> Void)?
    var didFailWithError: ((String) -> Void)?
    
    private(set) var videos = [Video]()
    
    private var isLoading = false
    private var currentPage = 1
    private var searchQueries: [String]?
    private var appendable = true
    
    private let getVideoList: FetchVideosUseCaseProtocol
    private let videoMapper: VideoMapper
    
    // Queue to handle requests sequentally
    private var requestQueue: [(() -> Void)] = []
    
    init(getVideoListUseCase: FetchVideosUseCaseProtocol, videoMapper: VideoMapper) {
        self.getVideoList = getVideoListUseCase
        self.videoMapper = videoMapper
    }
    
    public func retriveVideos(searchQueries: [String]?, completion: @escaping() -> Void) {
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
    
    
    private func loadVideos(searchQueries: [String]?, completion: @escaping() -> Void) {
        guard !isLoading else{
            return
        }
        
        isLoading = true
        
        if self.searchQueries != searchQueries {
            self.searchQueries = searchQueries
            self.currentPage = 1
            self.appendable = false
        }
        
        getVideoList.execute(page: self.currentPage, searchQueries: searchQueries) {[weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let newVideos):
                let newVids = newVideos.compactMap({
                    self?.videoMapper.map(dto: $0)
                })
                if self?.appendable == true {
                    self?.videos.append(contentsOf: newVids)
                    self?.currentPage += 1
                }else{
                    self?.videos = newVids
                    self?.appendable = true
                }
                self?.didFetchVideos?()
                completion()
            case .failure(let error):
                self?.didFailWithError?("Failed to fetch videos: \(error.localizedDescription)")
            }
            // After request is finished process next request
            self?.processNextRequest()
        }
    }
}
