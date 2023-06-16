//
//  CompraController.swift
//  LAvilaEcommerceVenta
//
//  Created by MacBookMBA16 on 02/06/23.
//

import UIKit
import iOSDropDown

class CompraController: UIViewController {

    var id : Int? = 0
    
 
    @IBOutlet weak var btnfinalizar: UIButton!
    
    
    @IBOutlet weak var ddlmostrarmp: DropDown!
    
    
    @IBOutlet weak var lblCantidadProducto: UILabel!
    
    
    @IBOutlet weak var labelCantidad: UILabel!
    
    var totalVenta : Double = 0
    var cantidadProductos : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ddlmostrarmp.didSelect{selectedText , index ,id in
            self.id = id
        }
        labelCantidad.text = String(totalVenta)
        lblCantidadProducto.text = String(cantidadProductos)
        
        print(totalVenta)
        // Do any additional setup after loading the view.
        ddlmostrarmp.optionArray = []
        ddlmostrarmp.optionIds = []
        
        let resultMetodoP = MetodoPViewModel.GetbAllMetodoPago()
        if resultMetodoP.Correct!{
            for objMetodoPago in resultMetodoP.Objects!{
                let metodo = objMetodoPago as! MetodoPagoViewModel
                //agregamos los datos de la bd en los arrays
                ddlmostrarmp.optionArray.append(metodo.Nombre!)
                ddlmostrarmp.optionIds?.append(metodo.idMetodoPago)
            }
        }
    }
    
    @IBAction func btnFincompra(_ sender: Any) {
        
        
    
   
        let alert = UIAlertController(title: "", message: "Se realizo la compra", preferredStyle: .alert)
        let height = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 320)
        let width = NSLayoutConstraint(item: alert.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
        alert.view.addConstraint(height)
        alert.view.addConstraint(width)
        let img = UIImageView(frame: CGRect(x: 40, y: 70, width: 200, height: 190))
        
       
        
        img.image = UIImage (named: "Finalizarcompra")
        let action = UIAlertAction (title: "Aceptar", style: .default,
            handler:
            { action in

          DispatchQueue.main.async {
              let Main = UIStoryboard(name: "Main", bundle: Bundle.main)
              guard let inicioVC = Main.instantiateViewController(withIdentifier: "PantallaRegreso") as? AreaController else {
                  return
              }
              //self.navigationController?.popToRootViewController(inicioVC, animated: true)
              self.navigationController?.popToViewController(inicioVC, animated: true)

              
         }
        })
       
        alert.view.addSubview(img)
        alert.addAction(action)
        present(alert, animated: true)
        
        
        
    }
    

}
