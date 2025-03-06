//
//  ViewController.swift
//  RedzExplorer
//
//  Created by homyt on 19/02/2025.
//

import UIKit
import SwiftUI
import XCoordinator

class VideoListViewController: UIViewController {
    
    @IBOutlet weak var videoList: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    private var activityIndicator: UIActivityIndicatorView!
    
    var selectedCategories: Set<Category> = [.all]
    
    var videoModel: VideoListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize activity indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        //setting up the category collection
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        // setting up the video list
        videoList.dataSource = self
        videoList.delegate = self
        
        
        // initially load all videos
        loadVideos(searchQueries: nil)
    }
    
    private func loadVideos(searchQueries: [String]?, filtering: Bool = false) {
        
        videoModel?.didUpdateLoadingState = { [weak self] (state: LoadingState<[Video]>) in
            guard let self
            else { return }
            self.videoList.isScrollEnabled = true
            
            switch state {
            case .idle:
                activityIndicator.stopAnimating()
            case .loading:
                activityIndicator.startAnimating()
            case .loaded(let result):
                switch result {
                case .success(let videos):
                    if videos.count == 0 {
                        let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
                        emptyLabel.text = "No Related Videos available"
                        emptyLabel.textAlignment = NSTextAlignment.center
                        self.videoList.backgroundView = emptyLabel
                        self.videoList.separatorStyle = UITableViewCell.SeparatorStyle.none
                    } else {
                        self.videoList.reloadData()
                    }
                case .failure(let error):
                    self.showError(message: error.localizedDescription)
                }
            }
        }
        if filtering {
            videoModel?.filterByCategory(searchQueries: searchQueries)
        }
        else{
            videoModel?.loadMoreVideos(searchQueries: searchQueries)
        }
        
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    func filterVideosByCategory() {
        // Scroll back to top and set flag while filtering
        videoList.isScrollEnabled = false
        
        if self.selectedCategories.contains(.all){
            loadVideos(searchQueries: nil, filtering: true)
        } else{
            let categories = Array(selectedCategories)
            loadVideos(searchQueries: categories.map({
                $0.displayName
            }), filtering: true)
        }
    }
    
    @objc func categoryButtonTapped(_ sender: UIButton) {
        guard let category = Category.allCases[safe: sender.tag] else {
            return
        }
        
        // If 'All' is selected, reset the selected categories
        if category == .all {
            selectedCategories.removeAll()
            selectedCategories.insert(.all)
        } else {
            selectedCategories.remove(.all)
            
            if selectedCategories.contains(category) {
                selectedCategories.remove(category)
            } else {
                selectedCategories.insert(category)
            }
            
            if selectedCategories.isEmpty {
                selectedCategories.insert(.all)
            }
        }
        
        // Scroll back to top and reload the collection view
        self.videoList.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        categoryCollectionView.reloadData()
        filterVideosByCategory()
    }
}


