//
//  LikeButtonRepresentable.swift
//  RedzExplorer
//
//  Created by homyt on 04/03/2025.
//

import SwiftUI

struct LikeButtonRepresentable: UIViewRepresentable {
    typealias UIViewType = LikeButton
    
    class Coordinator: NSObject {
        var button: LikeButton
        
        init(button: LikeButton) {
            self.button = button
        }
        
        @objc func toggleLike() {
            button.toggleLike()
        }
    }
    
    func makeUIView(context: Context) -> LikeButton {
        let button = LikeButton(type: .system)
        button.addTarget(context.coordinator, action: #selector(Coordinator.toggleLike), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: LikeButton, context: Context) {}
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(button: LikeButton())
        
    }
    
}
