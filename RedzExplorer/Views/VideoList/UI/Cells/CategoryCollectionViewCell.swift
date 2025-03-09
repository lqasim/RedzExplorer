//
//  CategoryCollectionViewCell.swift
//  RedzExplorer
//
//  Created by homyt on 21/02/2025.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    @IBOutlet weak var categoryButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUI()
    }
    
    private func setUpUI() {
        layer.cornerRadius = 15
        layer.borderColor = UIColor.systemBlue.cgColor
        backgroundColor = .lightGray
        categoryButton.setTitleColor(.black, for: .normal)
    }
    
    func updateUI(isSelected: Bool) {
        categoryButton.setTitleColor(isSelected ? .white : .black, for: .normal)
        
        backgroundColor = isSelected ? .systemBlue : .lightGray
    }
    
    static func calculateButtonWidth(title: String) -> CGFloat {
        return title.size(withAttributes: [.font: UIFont.systemFont(ofSize: 18)]).width + 25
    }
}
