//
//  ViewController.swift
//  RedzExplorer
//
//  Created by homyt on 19/02/2025.
//

import UIKit

class VideoListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        APIManager.shared.fetchVideos(page: 2, searchQuery: ["NEAREST","TOP_RAISING"]){ result in
            switch result {
            case .success(let videos):
                print(videos)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}

