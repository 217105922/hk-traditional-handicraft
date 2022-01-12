//
//  shopCell.swift
//  hk traditional handicraft
//
//  Created by peter lam on 13/1/2022.
//

import UIKit

class shopCell: UITableViewCell {
    
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var thrumbnail : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
