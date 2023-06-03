//
//  MetodoPViewModel.swift
//  LAvilaEcommerceVenta
//
//  Created by MacBookMBA16 on 02/06/23.
//

import Foundation
import UIKit
import SQLite3

class MetodoPViewModel{
    
    
//    static func GetbAllProducto(Sentencia : String) -> Result{
//        var context = DBManager()
//        var result = Result()
//        let query = "select IdProducto, Nombre, PrecioUnitario, Descripcion, Imagen From Productos where Nombre LIKE'%\(Sentencia)%'"
//        var statement : OpaquePointer?
//        do{
//            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
//                result.Objects = []
//                while try sqlite3_step(statement) == SQLITE_ROW {
//                    var metodopago = MetodoPagoViewModel()
//                    metodopago.idMetodoPago = Int(sqlite3_column_int(statement, 0))
//                    metodopago.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
//
//                    result.Objects?.append(producto)
//                }
//                result.Correct = true
//            }else  {
//                result.Correct = false
//                result.ErrorMessage = "Ocurrio un error"
//            }
//        }
//        catch let ex{
//            result.Correct = false
//            result.ErrorMessage = ex.localizedDescription //Ex.Message
//            result.Ex = ex
//        }
//        sqlite3_finalize(statement)
//        sqlite3_close(context.db)
//        return result
//    }
}
