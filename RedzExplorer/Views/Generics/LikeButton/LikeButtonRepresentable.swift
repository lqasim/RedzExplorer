//
//  LikeButtonRepresentable.swift
//  RedzExplorer
//
//  Created by homyt on 04/03/2025.
//

import SwiftUI

struct LikeButtonRepresentable: UIViewRepresentable {
  
    @Binding var isLiked: Bool
    
    class Coordinator: NSObject {
        var button: LikeButton
        @Binding var isLiked: Bool
        
        init(button: LikeButton, isLiked: Binding<Bool>) {
            self.button = button
            self._isLiked = isLiked
        }
        
        @objc func toggleLike() {
            isLiked.toggle()
            button.toggleLike()
        }
    }
    
    func makeUIView(context: Context) -> LikeButton {
        let button = LikeButton()
        
        button.likeCountChange = { isLiked in
            context.coordinator.isLiked = isLiked
        }
        button.addTarget(context.coordinator, action: #selector(Coordinator.toggleLike), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: LikeButton, context: Context) {}
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(button: LikeButton(), isLiked: $isLiked)
        
    }
    
}
