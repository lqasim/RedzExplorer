//
//  EmptyTableViewCell.swift
//  RedzExplorer
//
//  Created by homyt on 09/03/2025.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {
    
    static let identifier = "EmptyTableViewCell"
    
    @IBOutlet private weak var messageLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with message: String) {
        messageLbl.text = message
    }
    
}


extension EmptyTableViewCell {
    class func getCellHeight(in tableView: UITableView) -> CGFloat {
        return tableView.frame.height - tableView.safeAreaInsets.top - tableView.safeAreaInsets.bottom
    }
}
