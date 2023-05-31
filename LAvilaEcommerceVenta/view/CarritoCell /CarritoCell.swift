//
//  CarritoCell.swift
//  LAvilaEcommerceVenta
//
//  Created by MacBookMBA16 on 26/05/23.
//

import UIKit
import SwipeCellKit

class CarritoCell: SwipeTableViewCell {

    @IBOutlet weak var CarritoPrecio: UILabel!
    
    
    
    @IBOutlet weak var CarritoNom: UILabel!
    
    
    @IBOutlet weak var CarritoCantidad: UILabel!
    
    
    @IBOutlet weak var imagenview: UIImageView!
    
    
    @IBOutlet weak var StepperContador: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
