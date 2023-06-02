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
               //result.Correct = false
               result.Correct = true
           }
           catch let error {
               result.Correct = false
               result.ErrorMessage = error.localizedDescription
               result.Ex = error
           }
           
           return result
       }
    func Update(IdProducto : Int, cantidad : Int) -> Result{
           
           var result = Result()
        
        var ventasproductos = ProductoVentasViewModel()
        
           let context = appDelegate.persistentContainer.viewContext
           
        let response : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "VentaProducto")
           
           response.predicate = NSPredicate(format: "idProducto = \(IdProducto)")
        do{
            let test = try context.fetch(response)
            
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(cantidad, forKey: "cantidad")
            do{
                try context.save()
                result.Correct = true
                //result.Correct = false
            }catch let error{
                result.Correct = false
                result.ErrorMessage = error.localizedDescription
                result.Ex = error               }
        }catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        return result
       }
    
    
    
       func Delete(IdProducto : Int) -> Result{
         var result = Result()
           
           let context = appDelegate.persistentContainer.viewContext
           
           let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
           
           response.predicate = NSPredicate(format: "idProducto = \( IdProducto)")
           
           do{
               let test = try context.fetch(response)
               
               let objectToDelete = test[0] as! NSManagedObject
               context.delete(objectToDelete)
               do{
                   try context.save()
                  result.Correct = true
                   //result.Correct = false
               }catch let error{
                   result.Correct = false
                   result.ErrorMessage = error.localizedDescription
                   result.Ex = error               }
           }catch let error{
               result.Correct = false
               result.ErrorMessage = error.localizedDescription
               result.Ex = error
           }
           return result
       }

       func GetById(IdProducto : Int) -> Result{
           
           var result = Result()
           
           let context = appDelegate.persistentContainer.viewContext
           
           let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
          
           response.predicate = NSPredicate(format: "idProducto = \( IdProducto)")
           
           do{
               result.Object = []
               let resultFetch = try context.fetch(response)
               for obj in resultFetch as! [NSManagedObject]{
                   //Instancia de venta producto //Crear Modelo
                   let modeloventaproducto = ProductoVentasViewModel()
                   
                   modeloventaproducto.producto = Producto()
                   
                   modeloventaproducto.producto?.IdProducto =  obj.value(forKey:"idProducto") as! Int
                   modeloventaproducto.Cantidad = obj.value(forKey: "cantidad") as! Int
                
                   let result1 = ProductosViewModel.GetById(IdProducto: modeloventaproducto.producto?.IdProducto as! Int)
                   if result1.Correct!{
                       let producto = result1.Object! as! Producto
                       
                       modeloventaproducto.producto?.Nombre = producto.Nombre
                       modeloventaproducto.producto?.imagen = producto.imagen
                   }
                 
                   result.Object = modeloventaproducto
                  
               }
             
               //result.Correct = false
               result.Correct = true
           }
           catch let error {
               result.Correct = false
               result.ErrorMessage = error.localizedDescription
               result.Ex = error
           }
           
           return result
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
                       
                       modeloventaproducto.producto?.IdProducto =  obj.value(forKey:"idProducto") as! Int
                       modeloventaproducto.Cantidad = obj.value(forKey: "cantidad") as! Int
                    
                       let result1 = ProductosViewModel.GetById(IdProducto: modeloventaproducto.producto?.IdProducto as! Int)
                       if result1.Correct!{
                          // let producto = result1.Object! as! Departamento
                         let producto = result1.Object! as! Producto
                           
                           modeloventaproducto.producto?.Nombre = producto.Nombre
                           modeloventaproducto.producto?.imagen = producto.imagen
                           modeloventaproducto.producto?.PrecioUnitario = producto.PrecioUnitario
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
