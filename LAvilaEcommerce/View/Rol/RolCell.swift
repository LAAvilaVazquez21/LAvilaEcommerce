//
//  RolCell.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 09/05/23.
//

import UIKit
import SwipeCellKit


class RolCell: SwipeTableViewCell {

    
    @IBOutlet weak var lblidrol: UILabel!
    
    @IBOutlet weak var lblnombre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
