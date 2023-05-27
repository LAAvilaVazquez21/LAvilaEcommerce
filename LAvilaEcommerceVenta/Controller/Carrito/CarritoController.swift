//
//  CarritoController.swift
//  LAvilaEcommerceVenta
//
//  Created by MacBookMBA16 on 26/05/23.
//

import UIKit

class CarritoController: UITableViewController {
    
    let carritoViewModel = CarritoViewModel ()
    var producto : [Producto] = []
    
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
        return producto.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarritoCell", for: indexPath) as! CarritoCell
        
        
        cell.CarritoNombre.text = producto[indexPath.row].Nombre
       
        
        if producto[indexPath.row].imagen == "" || producto[indexPath.row].imagen == nil {
            cell.imagenview.image = UIImage(named: "DefaultProducto")
        }else{
            let string =  producto[indexPath.row].imagen
            
            
            let newImageData = Data(base64Encoded: string!)
            if let newImageData = newImageData {
                cell.imagenview.image = UIImage(data: newImageData)
            }
        }
        
        return cell
    }
    
    
    
    func UpdateUI(){
        var result = carritoViewModel.GetAll()
        producto.removeAll()
        if result.Correct!{
            for objUsuario in result.Objects!{
                let prod = objUsuario as! Producto //Unboxing
                producto.append(prod)
            }
            tableView.reloadData()
            
        }
    }
}





 

