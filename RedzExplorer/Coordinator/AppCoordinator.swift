//
//  AppCoordinator.swift
//  RedzExplorer
//
//  Created by homyt on 27/02/2025.
//
import UIKit
import SwiftUI
import XCoordinator

enum AppRoute: Route{
    case videoList
    case videoDetails(Video)
}


class AppCoordinator: NavigationCoordinator<AppRoute> {
    
    init() {
        super.init(initialRoute: .videoList)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .videoList:
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            guard let videoListVC = storyboard.instantiateViewController(identifier: "VideoListViewController") as? VideoListViewController else {
                fatalError("Could not instantiate VideoListViewController from storyboard")
            }
            videoListVC.viewModel = VideoListFactory.create(router: weakRouter)
            return .push(videoListVC)
            
        case .videoDetails(let video):
            let videoDetailsView = VideoDetailSwiftUIView(video: video)
            let hostingController = UIHostingController(rootView: videoDetailsView)
            return .push(hostingController)
        }
    }
}
