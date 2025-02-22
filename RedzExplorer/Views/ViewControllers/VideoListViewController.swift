//
//  ViewController.swift
//  RedzExplorer
//
//  Created by homyt on 19/02/2025.
//

import UIKit

class VideoListViewController: UIViewController {
    
    @IBOutlet weak var videoList: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    private var activityIndicator: UIActivityIndicatorView!
    
    var selectedCategories: Set<String> = ["All"]
    
    var videoModel = VideoListViewModel()
    
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
    
    private func loadVideos(searchQueries: [String]?) {
        
        activityIndicator.startAnimating()
        videoModel.loadVideos(searchQueries: searchQueries) { [weak self] success in
            
            // Stop loading indicator and reload table view
            self?.activityIndicator.stopAnimating()
            
            
            if success {
                DispatchQueue.main.async {
                    self?.videoList.isScrollEnabled = true
                    self?.videoList.reloadData()
                }
            }
            
        }
    }
    
    func filterVideosByCategory() {
        // Scroll back to top and set flag while filtering
        videoList.isScrollEnabled = false
        if self.selectedCategories.contains("All"){
            print("HERE")
            loadVideos(searchQueries: nil)
        } else{
            let categories = Array(selectedCategories)
            print(categories)
            loadVideos(searchQueries: categories)
        }
    }
    
    @objc func categoryButtonTapped(_ sender: UIButton) {
        let category = Constants.categories[sender.tag]
        
        if category == "All" {
            selectedCategories.removeAll()
            // deselect all other categories
            selectedCategories = ["All"]
        } else {
            // remove all as its the default
            selectedCategories.remove("All")
            
            // Toggle selection to remove if already exists
            if selectedCategories.contains(category) {
                selectedCategories.remove(category)
            } else{
                selectedCategories.insert(category)
            }
            
            // check if categories are empty add  All as a dfault
            if selectedCategories.isEmpty {
                selectedCategories.insert("All")
            }
        }
        self.videoList.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        categoryCollectionView.reloadData()
        filterVideosByCategory()
    }
}


