//
//  CarritoViewModel.swift
//  LAvilaEcommerceVenta
//
//  Created by MacBookMBA16 on 26/05/23.
//

import Foundation
import UIKit
import CoreData

class CarritoViewModel{
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
       
       func Add(_ IdProducto : Int) -> Result{
           var result = Result()
           
           let context = appDelegate.persistentContainer.viewContext
           
           let entity = NSEntityDescription.entity(forEntityName: "VentaProducto", in: context)!
           
           let alumno = NSManagedObject(entity: entity, insertInto: context)
           
           alumno.setValue(IdProducto, forKey: "idProducto")
           alumno.setValue(1, forKey: "cantidad")
           
           do{
               try context.save()
               result.Correct = true
           }
           catch let error {
               result.Correct = false
               result.ErrorMessage = error.localizedDescription
               result.Ex = error
           }
           
           return result
       }
       func Update(IdAlumno : Int){
           
       }
       func Delete(IdProducto : Int) -> Result{
           
           
           var result = Result()
           
           let context = appDelegate.persistentContainer.viewContext
           
           let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
           
           response.predicate = NSPredicate(format: "IdProducto = %@", IdProducto)
                   
           do{
               let test = try context.fetch(response)
               let objectToDelete = test[0] as! NSManagedObject
               context.delete(objectToDelete)
               do{
                   try context.save()
                   result.Correct = true
               }catch let error{
                   result.Correct = false
                   result.ErrorMessage = error.localizedDescription
                   result.Ex = error               }
           }
           return result
       }
       func GetById(IdAlumno : Int){
           
       }
       func GetAll() -> Result{
           var result = Result()
           
           let context = appDelegate.persistentContainer.viewContext
           
           let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
           
           do{
               result.Objects = []
               let resultFetch = try context.fetch(response)
               for obj in resultFetch as! [NSManagedObject]{
                   //Instancia de venta producto //Crear Modelo
                   let modeloventaproducto = ProductoVentasViewModel()
                   
                   modeloventaproducto.producto = Producto()
                   
                   modeloventaproducto.producto?.IdProducto =  obj.value(forKey: "idProducto") as! Int
                   modeloventaproducto.Cantidad = obj.value(forKey: "cantidad") as! Int
                
                   let result1 = ProductosViewModel.GetById(IdProducto: modeloventaproducto.producto?.IdProducto as! Int)
                   if result1.Correct!{
                       let producto = result1.Object! as! Producto
                       
                       modeloventaproducto.producto?.Nombre = producto.Nombre
                       modeloventaproducto.producto?.imagen = producto.imagen
                   }
                 
                   result.Objects?.append(modeloventaproducto)
                  
               }
               result.Correct = true
           }
           catch let error {
               result.Correct = false
               result.ErrorMessage = error.localizedDescription
               result.Ex = error
           }
           
           return result
       }
    
    
}
