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
    
    @IBOutlet weak var videoTableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var activityIndicator: UIActivityIndicatorView!
    
    var selectedCategories: Set<Category> = [.all]
    
    var viewModel: VideoListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize activity indicator
        SetUpActivivityIndicator()
        //setting up the category collection
        SetUpCollectionView()
        // setting up the video list
        SetUpListView()
        // initially load all videos
        loadVideos(searchQueries: nil)
    }
    
    private func loadVideos(searchQueries: [String]?, filtering: Bool = false) {
        
        viewModel?.didUpdateLoadingState = { [weak self] (state: LoadingState<[Video]>) in
            guard let self else { return }
            self.videoTableView.isScrollEnabled = true
            switch state {
            case .idle:
                activityIndicator.stopAnimating()
            case .loading:
                activityIndicator.startAnimating()
            case .loaded(let result):
                
                switch result {
                case .success(_):
                    self.videoTableView.reloadData()
                case .failure(let error):
                    self.showError(message: error.localizedDescription)
                }
            }
        }
        if filtering {
            viewModel?.filterByCategory(searchQueries: searchQueries)
        }
        else{
            viewModel?.loadMoreVideos(searchQueries: searchQueries)
        }
        
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    private func filterVideosByCategory() {
        // Scroll back to top and set flag while filtering
        videoTableView.isScrollEnabled = false
        
        if self.selectedCategories.contains(.all){
            loadVideos(searchQueries: nil, filtering: true)
        } else{
            let categories = Array(selectedCategories)
            loadVideos(searchQueries: categories.map({
                $0.displayName
            }), filtering: true)
        }
    }
    
    // Used in CollectoinViewDelegation
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
        self.videoTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        collectionView.reloadData()
        filterVideosByCategory()
    }
    
    
    private func SetUpActivivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    private func SetUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func SetUpListView() {
        videoTableView.dataSource = self
        videoTableView.delegate = self
    }
}


