//
//  GetAllProductoController.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 16/05/23.
//

import UIKit
import SQLite3
import SwipeCellKit

class GetAllProductoController: UITableViewController {
    
    
    var productos : [Producto] = []
    
    let dbmanager = DBManager()
    
    var IdProducto : Int = 0
    
    var IdArea : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        UdpateProd()
        tableView.reloadData()
      
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ProductosCell", bundle: .main), forCellReuseIdentifier:"ProductosCell")
        UdpateProd()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductosCell", for: indexPath) as! ProductosCell

        cell.delegate = self
        
        cell.lblnombre.text = productos[indexPath.row].Nombre
        cell.lblprecio.text = productos[indexPath.row].PrecioUnitario?.description
        cell.lbldescripcion.text = productos[indexPath.row].Descripcion
        cell.lbldepartamento.text = productos[indexPath.row].Departamento?.IdDepartamento?.description
        
 
        
        if productos[indexPath.row].imagen == "" || productos[indexPath.row].imagen == nil {
            cell.ImagenView.image = UIImage(named: "DefaultProducto")
        }else{
            let string =  productos[indexPath.row].imagen
                              
                               
                               let newImageData = Data(base64Encoded: string!)
                               if let newImageData = newImageData {
                                   cell.ImagenView.image = UIImage(data: newImageData)
                               }
        }

        return cell
    }
}

extension GetAllProductoController : SwipeTableViewCellDelegate{
     func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation)  -> [SwipeCellKit.SwipeAction]? {
        
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
                       

                let result =  ProductosViewModel.Delete(IdProducto: self.productos[indexPath.row].IdProducto!)
                
                if result.Correct! {
                    print("Producto Elimnado")
                    //self.UdpateUI()
                }else{
                    print("Ocurrio un error")
                }
                
            }
            return [deleteAction]
        }
        if orientation == .left {
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                
                self.IdProducto = self.productos[indexPath.row].IdProducto!
                self.performSegue(withIdentifier: "ProductoControler", sender: self)
                
            }
            return [updateAction]
        }
        return nil
    }
    
    func UdpateProd(){
        var result = ProductosViewModel.GetAll()
        productos.removeAll()
        if result.Correct!{
            for objProd in result.Objects!{
                let producti = objProd as! Producto //Unboxing
                productos.append(producti)
            }
            tableView.reloadData()
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               //controlar que hacer antes de ir a la siguiente vista
               if segue.identifier == "ProductoControler"{
                   let formControl = segue.destination as! FormProductosController
                   formControl.IdProducto = self.IdProducto
                   
                   
               }
           }
}
    
    

