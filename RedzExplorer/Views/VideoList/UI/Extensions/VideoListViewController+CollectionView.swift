//
//  VideoListViewControllerExtension.swift
//  RedzExplorer
//
//  Created by homyt on 22/02/2025.
//

import UIKit
import SwiftUI

// MARK: - Collection view data source and delegates
extension VideoListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // Data sources
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let category = Category.allCases[indexPath.item]
        
        cell.categoryButton.setTitle(category.displayName, for: .normal)
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
        let category = Category.allCases[indexPath.row]
        let width = CategoryCollectionViewCell.calculateButtonWidth(title: category.displayName)
        return CGSize(width: width, height: collectionView.frame.height - 10)
    }
}


