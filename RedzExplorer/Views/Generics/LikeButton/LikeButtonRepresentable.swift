//
//  LikeButtonRepresentable.swift
//  RedzExplorer
//
//  Created by homyt on 04/03/2025.
//

import SwiftUI

struct LikeButtonRepresentable: UIViewRepresentable {
    var viewModel: VideoDetailViewModel
    
    class Coordinator: NSObject {
        var viewModel: VideoDetailViewModel
        
        init(viewModel: VideoDetailViewModel) {
            //            self.button = button
            self.viewModel = viewModel
        }
        
        @objc func toggleLike() {
            viewModel.toggleLike()
        }
    }
    
    func makeUIView(context: Context) -> LikeButton {
        let button = LikeButton()
        button.addTarget(context.coordinator, action: #selector(Coordinator.toggleLike), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: LikeButton, context: Context) {
        uiView.setImage(viewModel.isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator( viewModel: viewModel)
    }
}
