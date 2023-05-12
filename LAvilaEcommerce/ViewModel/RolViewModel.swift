//
//  RolViewModel.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 09/05/23.
//

import Foundation
import SQLite3

class RolViewModel{
    
    
   
    
    static func Add(rol : Rol) -> Result{
        var result = Result()
        let context = DBManager()
        var statement : OpaquePointer? = nil
        var query = "INSERT INTO ROL (Nombre) VALUES (?)"
        
        do{
            if(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK){
                
                sqlite3_bind_text(statement, 1, (rol.Nombre as! NSString).utf8String, -1, nil)
                
                if(sqlite3_step(statement) == SQLITE_DONE){
                    result.Correct = true
                }else{
                    result.ErrorMessage = "no se agrego"
                }
            }else{
                result.Correct = false
                result.ErrorMessage = "Ocurrio un error"
            }
        }catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription //Ex.Message
            result.Ex = ex
            
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
        
    }
    
    static func Delete (idrol : Int) -> Result{
        var result = Result()
        var context = DBManager()
        var statement : OpaquePointer? = nil
        var query = "DELETE FROM Rol WHERE IdRol = \(idrol)"
        do{
            if try (sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK){
                if(sqlite3_step(statement) == SQLITE_DONE){
                    result.Correct = true
                }else{
                    result.ErrorMessage = "No se elimno correctamente"
                }
            }else{
                result.Correct = false
                result.ErrorMessage = "Ocurrio un error"
            }
            
        }catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    static func Update(rol : Rol) -> Result{
        var result = Result()
        let context = DBManager()
        var statement : OpaquePointer? = nil
        var query = "UPDATE Rol SET Nombre = ? WHERE IdRol = \(rol.idRol!)"
        
        do{
            if(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK){
                
                sqlite3_bind_text(statement, 1, (rol.Nombre as! NSString).utf8String, -1, nil)
                
                if(sqlite3_step(statement) == SQLITE_DONE){
                    result.Correct = true
                }else{
                    result.ErrorMessage = "no se actualizo"
                }
            }else{
                result.Correct = false
                result.ErrorMessage = "Ocurrio un error"
            }
        }catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription //Ex.Message
            result.Ex = ex
            
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
        
    }
    
    static func GetAll() -> Result{
        var result = Result()
        let context = DBManager()
        var statement : OpaquePointer?
        var query = "SELECT IdRol, Nombre FROM Rol"
        
        do{
            if(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK){
                result.Objects = []
                
                while try sqlite3_step(statement) == SQLITE_ROW{
                    var rol = Rol()
                    rol.idRol = Int(sqlite3_column_int(statement, 0))
                    rol.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    
                    result.Objects?.append(rol)
                    
                }
                result.Correct = true
            }else{
                result.Correct = false
                result.ErrorMessage = "Ocurrio un error"
            }
        }catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription //Ex.Message
            result.Ex = ex
            
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
        
    }
    
    static func GetByid(IdRol : Int) -> Result{
        var result = Result()
        let context = DBManager()
        var statement : OpaquePointer?
        var query = "SELECT IdRol, Nombre FROM Rol WHERE IdRol = \(IdRol)"
        
        do{
            if(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK){
    
                if try sqlite3_step(statement) == SQLITE_ROW{
                    var rol = Rol()
                    rol.idRol = Int(sqlite3_column_int(statement, 0))
                    rol.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    
                    result.Object = rol
                    
                }
                result.Correct = true
            }else{
                result.Correct = false
                result.ErrorMessage = "Ocurrio un error"
            }
        }catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription //Ex.Message
            result.Ex = ex
            
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
        
    }
    
}
