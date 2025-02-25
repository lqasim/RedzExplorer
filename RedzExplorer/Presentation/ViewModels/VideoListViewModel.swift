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
    
    init(getVideoListUseCase: FetchVideosUseCaseProtocol, videoMapper: VideoMapper) {
        self.getVideoList = getVideoListUseCase
        self.videoMapper = videoMapper
    }
    
    public func retriveVideos(searchQueries: [String]?) -> Void{
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
                print(self?.videos.count ?? 0)
                self?.didFetchVideos?()
            case .failure(let error):
                self?.didFailWithError?("Failed to fetch videos: \(error.localizedDescription)")
            }
            
        }
    }
}
