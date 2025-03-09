//
//  VideoListViewController+TableView.swift
//  RedzExplorer
//
//  Created by homyt on 09/03/2025.
//

import UIKit
import SwiftUI

// Video list data Source
extension VideoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let isEmpty = viewModel?.videos.isEmpty {
            return isEmpty ? 1 : viewModel?.videos.count ?? 1
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Return EmptyCell
        if viewModel?.videos.isEmpty ?? true {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier, for: indexPath) as? EmptyTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: "No Related Videos available")
            return cell
        }
        
        // Otherwise return video cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier, for: indexPath) as? VideoTableViewCell else{
            return UITableViewCell()
        }
        if let video = viewModel?.videos[indexPath.row] {
            cell.configure(with: (video))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel!.videos.isEmpty ? EmptyTableViewCell.getCellHeight(in: tableView) : VideoTableViewCell.getCellHeight()
    }
}

// MARK: - Video list delegates
extension VideoListViewController: UITableViewDelegate {
    // handle cell tapped and navigation to a seperate swiftUI UI (video details page)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel!.videos.isEmpty {
            return
        }
        guard let selectedVideo = self.viewModel?.videos[indexPath.row] else{
            return
        }
        viewModel?.showVideoDetails(selectedVideo)
    }
    
    // pagination based on willDisplay
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let totalRows = videoTableView.numberOfRows(inSection: 0)
        if indexPath.row == totalRows - 3 || indexPath.row == totalRows - 2 {
            // load more videos if not currently loading
            if viewModel?.loadingState != .loading {
                let searchQueryies = selectedCategories.contains(Category.all) ? nil : selectedCategories.map({$0.displayName})
                viewModel?.loadMoreVideos(searchQueries: searchQueryies)
            }
        }
    }
}
