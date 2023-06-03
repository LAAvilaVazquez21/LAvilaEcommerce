//
//  CarritoController.swift
//  LAvilaEcommerceVenta
//
//  Created by MacBookMBA16 on 26/05/23.
//

import UIKit
import SwipeCellKit

class CarritoController: UIViewController {
    
    
    @IBOutlet weak var totalCarrito: UILabel!
    
    @IBOutlet weak var Tableview: UITableView!
    
    var total : Double = 0
    var cantidadProductos : Int = 0
    var subtotal : Double = 0
    let carritoViewModel = CarritoViewModel ()
    var producto : [Producto] = []
    var productosventas : [ProductoVentasViewModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        Tableview.reloadData()
        UpdateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Tableview.register(UINib(nibName: "CarritoCell", bundle: .main), forCellReuseIdentifier:"CarritoCell")
        
        Tableview.dataSource = self
        Tableview.delegate = self
        UpdateUI()
    }
    
    
    

}

//MARK: TABLEVIEW
extension CarritoController :UITableViewDataSource, UITableViewDelegate{
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productosventas.count
       
        
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarritoCell", for: indexPath) as! CarritoCell
        
        cell.delegate = self
        
      
        cell.CarritoNom.text = productosventas[indexPath.row].producto?.Nombre
        cell.CarritoCantidad.text = productosventas[indexPath.row].Cantidad?.description
        cell.CarritoPrecio.text = productosventas[indexPath.row].producto?.PrecioUnitario?.description
        
        subtotal = Double(productosventas[indexPath.row].Cantidad! * (productosventas[indexPath.row].producto?.PrecioUnitario ?? 0)) //+= subtotal
        cell.CarritoPrecio.text = String (subtotal)
        
            self.total = total + subtotal
            
          
            
            totalCarrito.text = String(total)
        
        if productosventas[indexPath.row].producto?.imagen == "" || productosventas[indexPath.row].producto?.imagen == nil {
            cell.imagenview.image = UIImage(named: "DefaultProducto")
        }else{
            let string =  productosventas[indexPath.row].producto?.imagen
            
            
            let newImageData = Data(base64Encoded: string!)
            if let newImageData = newImageData {
                cell.imagenview.image = UIImage(data: newImageData)
            }
        }
        
        cell.StepperContador.value = Double(productosventas[indexPath.row].Cantidad!)
        cell.StepperContador.tag = indexPath.row
        cell.StepperContador.addTarget(self, action: #selector(Steeperaction), for: .touchUpInside)
        
       
        
        return cell
    }
}

extension CarritoController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
                
                
                let result =  carritoViewModel.Delete(IdProducto: self.productosventas[indexPath.row].producto!.IdProducto!)

                                if result.Correct! {
                                    print("usuario Elimnado")
                                    self.UpdateUI()
                                }else{
                                    print("Ocurrio un error")
                                }

                
            }
            return [deleteAction]
        }
        if orientation == .left {
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                
                //                self.IdUsuario = self.usuarios[indexPath.row].IdUsuario!
                //                self.performSegue(withIdentifier: "UsuarioControler", sender: self)
                //
            }
            return [updateAction]
        }
        return nil
        
        
    }
    
    func UpdateUI(){
        
        var result = carritoViewModel.GetAll()
        productosventas.removeAll()
        if result.Correct!{
            for objUsuario in result.Objects!{
                total = 0
                let prod = objUsuario as! ProductoVentasViewModel //Unboxing
               
                productosventas.append(prod)
                cantidadProductos = prod.Cantidad!
                
            }
            
            Tableview.reloadData()
            print(cantidadProductos)
        }
    }
    
    @objc func Steeperaction(sender: UIStepper){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        print("sender ---> \(sender.value)")
        if sender.value >= 1{
            if carritoViewModel.Update(IdProducto: (productosventas[indexPath.row].producto?.IdProducto)!,cantidad: Int(sender.value)).Correct!{
                total = 0.0
                
                UpdateUI()
                print("Actualizo")
                
            }else{
                print("no se puede actualizar")
            }
        }else{
            if (sender.value == 0){
                let result =  carritoViewModel.Delete(IdProducto: self.productosventas[indexPath.row].producto!.IdProducto!)
                
                if result.Correct! {
                    print("usuario Elimnado")
                    self.UpdateUI()
                }else{
                    print("Ocurrio un error")
                }
            }
            print("no se hace nada")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               //controlar que hacer antes de ir a la siguiente vista
               if segue.identifier == "CompraResumen"{
                   let formControl = segue.destination as! CompraController
                   formControl.totalVenta = total
                   formControl.cantidadProductos = cantidadProductos
                   
                   
               }
           }
}





 

