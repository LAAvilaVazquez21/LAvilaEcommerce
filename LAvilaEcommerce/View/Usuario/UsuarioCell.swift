//
//  UsuarioCell.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 03/05/23.
//

import UIKit
import SwipeCellKit

class UsuarioCell: SwipeTableViewCell {

    @IBOutlet weak var lblNombreOutlet: UILabel!
    
    @IBOutlet weak var lblFechaN: UILabel!
    
    @IBOutlet weak var lblApellidoP: UILabel!
    
    @IBOutlet weak var lblUserNameOutlet: UILabel!
    
    @IBOutlet weak var lblRolOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
