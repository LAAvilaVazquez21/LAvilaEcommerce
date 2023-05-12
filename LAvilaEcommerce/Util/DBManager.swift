//
//  DBManager.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 28/04/23.
//

import Foundation
import SQLite3

class DBManager{
    ///func GET(){
        //CREAR CONEXION
        //RETONAR UNA CONEXION
        //SE CREA ARCHIVO SQL
        
    var db:OpaquePointer?
    let path : String = "Document.LAvilaEcommerce.sqlite"
     
        
    init()
    {
        self.db = Get()
    }

    
        func Get() -> OpaquePointer?
        {
            let filePath = try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(path)
           
            if (sqlite3_open(filePath.path, &db) == SQLITE_OK)
            {
                print("conexion exitosa")
                print(filePath)
                return db
            }
            else
            {
                print("Fallo la conexion")
                return nil
            }
            
        }
    }
    

