//
//  ProductosCell.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 16/05/23.
//

import UIKit
import SwipeCellKit

class ProductosCell: SwipeTableViewCell {

    @IBOutlet weak var lblnombre: UILabel!
    @IBOutlet weak var lbldepartamento: UILabel!
    @IBOutlet weak var lbldescripcion: UILabel!
    @IBOutlet weak var lblprecio: UILabel!
    
    
    @IBOutlet weak var ImagenView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
