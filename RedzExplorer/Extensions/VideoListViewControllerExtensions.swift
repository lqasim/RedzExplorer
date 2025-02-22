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
        return self.videoModel.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoCellTableViewCell.identifier, for: indexPath) as? VideoCellTableViewCell else{
            return UITableViewCell()
        }
        
        cell.configure(with: self.videoModel.videos[indexPath.row])
        
        return cell
    }
    
    
}

//Video list delegates
extension VideoListViewController: UITableViewDelegate {
    // handle cell tapped and navigation to a seperate swiftUI UI (video details page)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVideo = self.videoModel.videos[indexPath.row]
        let videoDetailsView = VideoDetailSwiftUIView(video: selectedVideo)
        let hostingController = UIHostingController(rootView: videoDetailsView)
        self.navigationController?.pushViewController(hostingController, animated: true)
        
    }
    
    // In order to implement pagination, utilize screen width and when user reaches the end
    // get next page info
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // add a checking that the scrolling is happining on the tableview not the collection horizontal scrollable
        if scrollView == videoList {
            let contentHeight = scrollView.contentSize.height
            let scrollPosition = scrollView.contentOffset.y + scrollView.frame.size.height
            
            if contentHeight - scrollPosition < 100 {
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
        return Constants.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let category = Constants.categories[indexPath.item]
        
        cell.categoryButton.setTitle(category, for: .normal)
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
        let category = Constants.categories[indexPath.item]
        // .size for string is used here as a size calucator based on the text size and font etc..
        let width = category.size(withAttributes: [.font: UIFont.systemFont(ofSize: 18)]).width + 25
        
        return CGSize(width: width, height: collectionView.frame.height - 10)
    }
}
