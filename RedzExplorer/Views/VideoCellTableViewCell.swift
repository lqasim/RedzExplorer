//
//  VideoCellTableViewCell.swift
//  RedzExplorer
//
//  Created by homyt on 20/02/2025.
//

import UIKit

class VideoCellTableViewCell: UITableViewCell {
    static let identifier = "VideoCellTableViewCell"
        
    @IBOutlet weak var videoThumbnailImg: UIImageView!
    
    @IBOutlet weak var usenNameLbl: UILabel!
    
    @IBOutlet weak var videoCategoryLbl: UILabel!
    
    @IBOutlet weak var videoDescriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with model: Video) {
        self.videoThumbnailImg.image = UIImage(named: "Image")
        self.usenNameLbl.text = model.user.userName
        self.videoCategoryLbl.text = model.postCategory?.joined()
        self.videoDescriptionLbl.text = model.description?.capitalized
    }
}
