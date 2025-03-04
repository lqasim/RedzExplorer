//
//  LikeButton.swift
//  RedzExplorer
//
//  Created by homyt on 04/03/2025.
//

import UIKit

class LikeButton: UIButton {
    
    private let emptyHeartImage = UIImage(systemName: "heart")
    private let filledHeartImage = UIImage(systemName: "heart.fill")
    
    private var isLiked = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        setImage(emptyHeartImage, for: .normal)
        
        self.tintColor = .red
        self.addTarget(self, action: #selector(toggleLike), for: .touchUpInside)
    }
    
    @objc func toggleLike() {
        isLiked = !isLiked
        let image = isLiked ? filledHeartImage : emptyHeartImage
        setImage(image, for: .normal)
    }
}

