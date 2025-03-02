//
//  VideoCellTableViewCell.swift
//  RedzExplorer
//
//  Created by homyt on 20/02/2025.
//

import UIKit
import SDWebImage
import SkeletonView

class VideoCellTableViewCell: UITableViewCell {
    static let identifier = "VideoCellTableViewCell"
    
    @IBOutlet weak var videoThumbnailImg: UIImageView!
    
    @IBOutlet weak var usenNameLbl: UILabel!
    
    @IBOutlet weak var phoneNoLal: UILabel!
    
    @IBOutlet weak var videoCategoryLbl: UILabel!
    
    @IBOutlet weak var videoDescriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // set Ui elements to skeletonable
        videoThumbnailImg.isSkeletonable = true
        usenNameLbl.isSkeletonable = true
        phoneNoLal.isSkeletonable = true
        videoCategoryLbl.isSkeletonable = true
        videoDescriptionLbl.isSkeletonable = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with model: Video) {
        videoThumbnailImg.showAnimatedGradientSkeleton()
        // configure image
        let thumbnailUrlString = model.postThumbnailImageURL
        
        if let url = URL(string: thumbnailUrlString) {
            videoThumbnailImg.sd_setImage(with: url) { image, error, cacheType, url in

                self.videoThumbnailImg.hideSkeleton()
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                }

            }

        }
        
        
        self.usenNameLbl.text = model.user.userName
        self.videoCategoryLbl.text = model.postCategory.joined()
        self.phoneNoLal.text = "Contact: \(model.user.phoneNumber)"
        
        // description might be in arabic or english : didn't effect text handling might be removed
        let descriptionText = model.description
        self.videoDescriptionLbl.text = descriptionText
        self.videoDescriptionLbl.textAlignment = isTextRTL(descriptionText) ? .right : .left
        self.videoDescriptionLbl.semanticContentAttribute = isTextRTL(descriptionText) ? .forceRightToLeft : .forceLeftToRight
    }
    
    func isTextRTL(_ text: String) -> Bool {
        return text.rangeOfCharacter(from: CharacterSet(charactersIn: "\u{0600}-\u{06FF}")) != nil
    }
}


