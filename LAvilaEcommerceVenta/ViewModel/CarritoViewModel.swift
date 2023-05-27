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
       func Delete(IdAlumno : Int){
           
       }
       func GetById(IdAlumno : Int){
           
       }
       func GetAll() -> Result{
           var result = Result()
           
           let context = appDelegate.persistentContainer.viewContext
           
           let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
           
           do{
               let resultFetch = try context.fetch(response)
               for obj in resultFetch as! [NSManagedObject]{
                   //Instancia de venta producto //Crear Modelo
                   let idProducto = obj.value(forKey: "idProducto")
                   let cantidad = obj.value(forKey: "cantidad")
                   print(idProducto!)
                   print(cantidad!)
                   let result = ProductosViewModel.GetById(IdProducto: idProducto as! Int)
                   //result.objects.add(MODELOVENTAPRODUCTO)
               }
           }
           catch let error {
               result.Correct = false
               result.ErrorMessage = error.localizedDescription
               result.Ex = error
           }
           
           return result
       }
    
    
}
