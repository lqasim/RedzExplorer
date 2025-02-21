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
    
    private var videoModel = VideoListViewModel()
    
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

// Video list data Source
extension VideoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoModel.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoCellTableViewCell.identifier, for: indexPath) as? VideoCellTableViewCell else{
            return UITableViewCell()
        }
        
        cell.configure(with: videoModel.videos[indexPath.row])
        
        return cell
    }
    
    
}
//Video list delegates
extension VideoListViewController: UITableViewDelegate {
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
