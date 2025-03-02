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
    
    // limit pagination to one page at a time
    var isPagination = false
    
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
        
        // prepare videoModel
        prepareVideoModel()
        // initially load all videos
        loadVideos(searchQueries: nil)
    }
    
    private func loadVideos(searchQueries: [String]?) {
        
        activityIndicator.startAnimating()
        videoModel?.retrieveVideos(searchQueries: searchQueries) {
            self.activityIndicator.stopAnimating()
            self.isPagination = false
        }
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func prepareVideoModel() {
        videoModel?.didFetchVideos = { [weak self] in
            self?.videoList.isScrollEnabled = true
            if self?.videoModel?.videos.count == 0 {
                let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self?.view.bounds.size.width ?? 150, height: self?.view.bounds.size.height ?? 150))
                emptyLabel.text = "No Related Videos available"
                emptyLabel.textAlignment = NSTextAlignment.center
                self?.videoList.backgroundView = emptyLabel
                self?.videoList.separatorStyle = UITableViewCell.SeparatorStyle.none
            }
            self?.videoList.reloadData()
        }
        
        videoModel?.didFailWithError = { [weak self]err in
            self?.showError(message: err)
        }
    }
    
    func filterVideosByCategory() {
        // Scroll back to top and set flag while filtering
        videoList.isScrollEnabled = false

        if self.selectedCategories.contains(.all){
            loadVideos(searchQueries: nil)
        } else{
            let categories = Array(selectedCategories)
            loadVideos(searchQueries: categories.map({
                $0.displayName
            }))
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


