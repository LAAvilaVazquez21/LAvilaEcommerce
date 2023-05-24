//
//  DepartamentoViewModel.swift
//  LAvilaEcommerce
//
//  Created by Luis Angel on 23/05/23.
//
import Foundation
import SQLite3

class DepartamentoViewModel{
    
    var result = Result()
    var context = DBManager()

    
    static func GetbyidArea(IdArea : Int) -> Result{
        var context = DBManager()
        var result = Result()
        let query = "SELECT IdDepartamento, Nombre FROM Departamento WHERE Departamento.IdArea = \(IdArea)"
        var statement : OpaquePointer?
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while try sqlite3_step(statement) == SQLITE_ROW {
                    var departamento = Departamento()
                    departamento.IdDepartamento = Int(sqlite3_column_int(statement, 0))
                    departamento.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    
                    result.Objects?.append(departamento)
                }
                result.Correct = true
            }else  {
                result.Correct = false
                result.ErrorMessage = "Ocurrio un error"
            }
        }
        catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription //Ex.Message
            result.Ex = ex
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
}

