//
//  CompraController.swift
//  LAvilaEcommerceVenta
//
//  Created by MacBookMBA16 on 02/06/23.
//

import UIKit

class CompraController: UIViewController {

    
    @IBOutlet weak var lblCantidadProducto: UILabel!
    
    
    @IBOutlet weak var labelCantidad: UILabel!
    
    var totalVenta : Double = 0
    var cantidadProductos : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelCantidad.text = String(totalVenta)
        lblCantidadProducto.text = String(cantidadProductos)

print(totalVenta)
        // Do any additional setup after loading the view.
    }

}
