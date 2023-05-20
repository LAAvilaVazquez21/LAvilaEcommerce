//
//  FormProductosController.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 16/05/23.
//

import Foundation
import SwipeCellKit
import SQLite3
import UIKit
import iOSDropDown

class FormProductosController :UIViewController{
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var btnAction: UIButton!
    
    
    @IBOutlet weak var txtiddepartamento: DropDown!
    

    @IBOutlet weak var txtidproducto: UITextField!
    
    
    @IBOutlet weak var txtNombreProducto: UITextField!
    
    
    @IBOutlet weak var txtPrecioProducto: UITextField!
    
    @IBOutlet weak var txtStockProducto: UITextField!
    
    @IBOutlet weak var txtDescripcionproducto: UITextField!
    
    
    @IBOutlet weak var txtIdProveedorP: DropDown!
    var IdProducto : Int = 0
    var IdProveedor : Int = 0
    var IdDepartamento : Int = 0
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        //gaurdadmos el id del dropdwon
        txtIdProveedorP.didSelect{selectedText , index ,id in
            self.IdProveedor = id
        }
        txtiddepartamento.didSelect{selectedText , index ,id in
            self.IdDepartamento = id
        }
        
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.isEditing = false
        
        txtIdProveedorP.optionArray = []
        txtIdProveedorP.optionIds = []
        
     
        let resultproducto = ProductosViewModel.GetAll()
        if resultproducto.Correct!{
            for objprod in resultproducto.Objects!{
                let producto = objprod as! Producto
               
                //agregamos los datos de la bd en los arrays
                txtIdProveedorP.optionArray.append(producto.Proveedor?.Nombre! ?? "")
                txtIdProveedorP.optionIds?.append(producto.Proveedor?.IdProveedor ?? 0)
                
            }
            
        }
        
        txtiddepartamento.optionArray = []
        txtiddepartamento.optionIds = []
        
        let resultproducto1 = ProductosViewModel.GetAll()
        if resultproducto1.Correct!{
            for objproddep in resultproducto.Objects!{
                let productodepartamento = objproddep as! Producto
               
                //agregamos los datos de la bd en los arrays
                txtiddepartamento.optionArray.append(productodepartamento.Departamento?.Nombre ?? "")
                txtiddepartamento.optionIds?.append(productodepartamento.Departamento?.IdDepartamento ?? 0)
                
            }
            
        }
        
        print(IdProducto)
        
        if IdProducto == 0{
            
            
            btnAction.backgroundColor = .green
            btnAction.setTitle("Agregar", for: .normal)
        }else{
            
            let producto = ProductosViewModel.GetById(IdProducto: IdProducto)
            
            let acceder = producto.Object as! Producto
            
            self.txtidproducto.text = acceder.IdProducto?.description
            self.txtNombreProducto.text = acceder.Nombre
            self.txtPrecioProducto.text = acceder.PrecioUnitario?.description
            self.txtStockProducto.text = acceder.Stock?.description
            self.txtDescripcionproducto.text = acceder.Descripcion
            self.txtIdProveedorP.text = acceder.Proveedor?.Nombre
            self.txtiddepartamento.text = acceder.Departamento?.Nombre
            
            btnAction.backgroundColor = .yellow
            btnAction.setTitle("Actualizar", for: .normal)
            
        }
        
    }
    
    
    @IBAction func btnRecuperarDatos(_ sender: UIButton) {
        
//        let producto = Producto()
//        
//        let imagen = imageView.image
//        producto.imagen = convertToBase64(imagen: imagen!)//Convertir a base 64
        
        let opcion = btnAction.titleLabel?.text
                switch opcion{
                case "Agregar":
                    var producto = Producto()
                    
                    producto.Nombre = txtNombreProducto.text!
                    producto.PrecioUnitario = Int(txtPrecioProducto.text!)
                    producto.Stock = Int(txtStockProducto.text!)
                    producto.Descripcion = txtDescripcionproducto.text!
                   
                   producto.imagen = convertToBase64()
                    producto.Proveedor = Proveedor()
                    producto.Proveedor?.IdProveedor = self.IdProveedor
                    producto.Departamento = Departamento()
                    producto.Departamento?.IdDepartamento = self.IdDepartamento
                    
                    
                    let result = ProductosViewModel.Add(producto: producto)
                    if result.Correct! {
                        let alert = UIAlertController(title: "Mensaje", message: "Producto Agregado correctamente", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                        
                        
                        
                    }
                    break
                case "Actualizar":
                    var producto = Producto()
                    
                    producto.IdProducto = Int(txtidproducto.text!) ?? 0
                    producto.Nombre = txtNombreProducto.text!
                    producto.PrecioUnitario = Int(txtPrecioProducto.text!)
                    producto.Stock = Int(txtStockProducto.text!)
                    producto.Descripcion = txtDescripcionproducto.text!
                    producto.imagen = convertToBase64()
                    producto.Proveedor = Proveedor()
                    producto.Proveedor?.IdProveedor = self.IdProveedor
                    producto.Departamento = Departamento()
                    producto.Departamento?.IdDepartamento = self.IdDepartamento

                    
                    let result = ProductosViewModel.Update(producto : producto)
                    if result.Correct! {
                        let alert = UIAlertController(title: "Mensaje", message: "Producto actualizado correctamente", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                       
                    }
                    break
                default:
                    print("No se realizo nada")
                }
            }
    
    @IBAction func imagePickerController(_ sender: UIButton) {
        self.present(imagePickerController, animated: true)    }
    
    }
    
// MARK: ImageView
extension FormProductosController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let data = info[.originalImage]
        self.imageView.image = info[.originalImage] as! UIImage
        
        dismiss(animated: true)
    }
    func convertToBase64 () -> String{
        let base64 = (imageView.image?.pngData()?.base64EncodedString())!
               //print("Base64 \(base64)")
               return base64
    }
    
}
