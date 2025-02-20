//
//  ViewController.swift
//  RedzExplorer
//
//  Created by homyt on 19/02/2025.
//

import UIKit

class VideoListViewController: UIViewController {
    
    @IBOutlet weak var videoList: UITableView!
    
    private var videoModel = VideoListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        videoList.dataSource = self
        videoList.delegate = self
        loadVideos()
    }
    
    func loadVideos() {
        videoModel.loadVideos(searchQueries: nil) { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.videoList.reloadData()
                }
            }
            
        }
    }
}

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

extension VideoListViewController: UITableViewDelegate {
    // In order to implement pagination, utilize screen width and when user reaches the end
    // get next page info
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let scrollPosition = scrollView.contentOffset.y + scrollView.frame.size.height
        
        if contentHeight - scrollPosition < 100 {
            // needs to load next page
            loadVideos()
        }
    }
    
}

