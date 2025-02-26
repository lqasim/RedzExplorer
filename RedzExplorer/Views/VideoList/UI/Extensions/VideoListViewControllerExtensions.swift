//
//  VideoListViewControllerExtension.swift
//  RedzExplorer
//
//  Created by homyt on 22/02/2025.
//

import UIKit
import SwiftUI

// Video list data Source
extension VideoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let videoCount = videoModel?.videos.count, videoCount != 0 else{
            return 0
        }
        tableView.backgroundView = nil
        return videoCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoCellTableViewCell.identifier, for: indexPath) as? VideoCellTableViewCell else{
            return UITableViewCell()
        }
        if let video = videoModel?.videos[indexPath.row] {
            cell.configure(with: (video))
        }
        
        return cell
    }
    
    
}

//Video list delegates
extension VideoListViewController: UITableViewDelegate {
    // handle cell tapped and navigation to a seperate swiftUI UI (video details page)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedVideo = self.videoModel?.videos[indexPath.row] else{
            return
        }
        coordinator?.showVideoDetails(video: selectedVideo)
//        let videoDetailsView = VideoDetailSwiftUIView(video: selectedVideo)
//        let hostingController = UIHostingController(rootView: videoDetailsView)
//        self.navigationController?.pushViewController(hostingController, animated: true)
        
        
    }
    
    // In order to implement pagination, utilize screen width and when user reaches the end
    // get next page info
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // add a checking that the scrolling is happining on the tableview not the collection horizontal scrollable
        if scrollView == videoList {
            let contentHeight = scrollView.contentSize.height
            let scrollPosition = scrollView.contentOffset.y + scrollView.frame.size.height
            
            if contentHeight - scrollPosition < 100 && !isPagination {
                isPagination = true
                // needs to load next page
                filterVideosByCategory()
            }
        }
        
    }
    
}


// Collection view data source and delegates
extension VideoListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // Data sources
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let category = Category.allCases[indexPath.item]
        
        cell.categoryButton.setTitle(category.displayName, for: .normal)
        cell.updateUI(isSelected: selectedCategories.contains(category))
        // button tapped
        cell.categoryButton.tag = indexPath.item
        cell.categoryButton.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
}



// specifies the layout flow
extension VideoListViewController: UICollectionViewDelegateFlowLayout {
    
    // calculates the button size dynamically based on teh text inside of it
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let category = Category.allCases[indexPath.row]
        // .size for string is used here as a size calucator based on the text size and font etc..
        let width = category.displayName.size(withAttributes: [.font: UIFont.systemFont(ofSize: 18)]).width + 25
        
        return CGSize(width: width, height: collectionView.frame.height - 10)
    }
}

// Helper to safely access elements of an array with index checking
extension Array {
    subscript(safe index: Int) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
        
    }
}
