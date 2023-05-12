//
//  Usuario.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 28/04/23.
//

import Foundation
import SQLite3

class Usuario
{
    
    //    init()
    //    {
    //       var db = DBManager()
    //
    //    }
    
    //Propiedades
    var IdUsuario : Int? = nil
    var Nombre: String? = nil
    var ApellidoPaterno : String? = nil
    var ApellidoMaterno : String? = nil
    var FechaNacimiento : String? = nil
    var Username : String? = nil
    var Password : String? = nil
    
    //propiedades de navegacion
    var rol : Rol? = nil
    
    
}
