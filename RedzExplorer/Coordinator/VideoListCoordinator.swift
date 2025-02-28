//
//  VideoListCoordinator.swift
//  RedzExplorer
//
//  Created by homyt on 26/02/2025.
//

//import UIKit
//import SwiftUI
//
//class VideoListCoordinator: Coordinator {
//    private var navigationController: UINavigationController
//    private var videoListViewModel: VideoListViewModel
//
//    init(navigationController: UINavigationController, videoListViewModel: VideoListViewModel) {
//        self.navigationController = navigationController
//        self.videoListViewModel = videoListViewModel
//    }
//
//    func start() {
//        let storyboard = UIStoryboard(name: "Home", bundle: nil)
//        guard let videoListVC = storyboard.instantiateViewController(identifier: "VideoListViewController") as? VideoListViewController else {
//            fatalError("Could not instantiate VideoListViewController from storyboard")
//        }
//        videoListVC.videoModel = videoListViewModel
//        videoListVC.coordinator = self
//        navigationController.pushViewController(videoListVC, animated: false)
//    }
//
//    func showVideoDetails(video: Video) {
//        // Navigate to the video details screen
//        let videoDetailsView = VideoDetailSwiftUIView(video: video)
//        let hostingController = UIHostingController(rootView: videoDetailsView)
//        navigationController.pushViewController(hostingController, animated: true)
//    }
//}
