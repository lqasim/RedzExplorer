//
//  VideoListViewModel.swift
//  RedzExplorer
//
//  Created by homyt on 20/02/2025.
//

import Foundation


class VideoListViewModel {
    
    private(set) var videos = [Video]()
    private var currentPage = 1
    private var isLoading = false
    private var searchQueries: [String]?
    
    
    func loadVideos(searchQueries: [String]?, completion: @escaping (Bool) -> Void) {
        print("Current Page: \(currentPage)")
        // check if it is already loading then don't allow to load again
        // fixed problem with paginiation using scrolling
        guard !isLoading else {
            return
            
        }
        
        isLoading = true
        
        // if the search query differes then revist page 1
        if self.searchQueries != searchQueries {
            self.searchQueries = searchQueries
            self.videos = []
            self.currentPage = 1
        }
        
        APIManager.shared.fetchVideos(page: self.currentPage, searchQueries: searchQueries) { [weak self] results in
            
            self?.isLoading = false
            
            switch results {
            case .success(let newvideos):
                // check if same search query then we are moving page and appending current videos
                if searchQueries ==  self?.searchQueries {
                    self?.videos.append(contentsOf: newvideos)
                    self?.currentPage += 1
                } else {
                    self?.videos = newvideos
                    self?.searchQueries = searchQueries
                    self?.currentPage = 1
                }
                
                completion(true)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
                
            }
            
        }
        
        
    }
}
