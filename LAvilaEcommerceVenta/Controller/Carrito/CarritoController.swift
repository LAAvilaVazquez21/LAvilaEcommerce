//
//  CarritoController.swift
//  LAvilaEcommerceVenta
//
//  Created by MacBookMBA16 on 26/05/23.
//

import UIKit
import SwipeCellKit

class CarritoController: UITableViewController {
    
    let carritoViewModel = CarritoViewModel ()
    var producto : [Producto] = []
    var productosventas : [ProductoVentasViewModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        UpdateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CarritoCell", bundle: .main), forCellReuseIdentifier:"CarritoCell")
        
        UpdateUI()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productosventas.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarritoCell", for: indexPath) as! CarritoCell
        
        cell.delegate = self
        
        cell.CarritoNombre.text = productosventas[indexPath.row].producto?.Nombre
        cell.CarritoCantidad.text = productosventas[indexPath.row].Cantidad?.description
        
        if productosventas[indexPath.row].producto?.imagen == "" || productosventas[indexPath.row].producto?.imagen == nil {
            cell.imagenview.image = UIImage(named: "DefaultProducto")
        }else{
            let string =  productosventas[indexPath.row].producto?.imagen
            
            
            let newImageData = Data(base64Encoded: string!)
            if let newImageData = newImageData {
                cell.imagenview.image = UIImage(data: newImageData)
            }
        }
        
        return cell
    }
    
    
    

}

extension CarritoController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
                
                
                // let result =  UsuarioViewModel.Delete(IdUsuario: self.usuarios[indexPath.row].IdUsuario!)
                
                //                if result.Correct! {
                //                    print("usuario Elimnado")
                //                    self.UdpateUI()
                //                }else{
                //                    print("Ocurrio un error")
                //                }
                
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
                let prod = objUsuario as! ProductoVentasViewModel //Unboxing
                productosventas.append(prod)
            }
            tableView.reloadData()
            
        }
    }
}





 

