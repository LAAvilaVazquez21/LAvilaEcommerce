//
//  ProductosColeccionController.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 23/05/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProductosColeccionController: UICollectionViewController {
    
    var producto : [Producto] = []
    
    var IdDepartamento : Int = 0
    var Id : Int = 0
    var datotxt : String = ""
    
    @IBOutlet var itemprod: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "ProductosCardViewCell", bundle: .main), forCellWithReuseIdentifier: "ProductosCardViewCell")
        itemprod.delegate = self
        itemprod.dataSource = self
        
        
        print("el area es: \(IdDepartamento)")
        print("el area es: \(datotxt)")
        
        if IdDepartamento == 0{
            
            var result = ProductosViewModelLike.GetbAllProducto(Sentencia: datotxt)
            producto.removeAll()
            if result.Correct!{
                for objdepartamento in result.Objects!{
                    let resultado = objdepartamento as! Producto
                    //Unboxing
                    producto.append(resultado)
                }
                collectionView?.reloadData()
            }
            
        }else{
            
            var result = ProductosCardViewModel.GetbAllProducto(IdDepartamento: IdDepartamento)
            producto.removeAll()
            if result.Correct!{
                for objdepartamento in result.Objects!{
                    let resultado = objdepartamento as! Producto
                    //Unboxing
                    producto.append(resultado)
                }
                collectionView?.reloadData()
            }
        }
        
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return producto.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductosCardViewCell", for: indexPath) as! ProductosCardViewCell
        
        cell.lblnombre.text = producto[indexPath.row].Nombre
        cell.lblPrecio.text = producto[indexPath.row].PrecioUnitario?.description
        cell.lblDescripcion.text = producto[indexPath.row].Descripcion
        
        if producto[indexPath.row].imagen == "" || producto[indexPath.row].imagen == nil {
            cell.imagenView.image = UIImage(named: "DefaultProducto")
        }else{
            let string =  producto[indexPath.row].imagen
            
            
            let newImageData = Data(base64Encoded: string!)
            if let newImageData = newImageData {
                cell.imagenView.image = UIImage(data: newImageData)
            }
        }
        
        return cell
        
    }
    
}

