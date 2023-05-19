//
//  GetAllUsuarioController.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 03/05/23.
//

import UIKit
import SwipeCellKit

class GetAllUsuarioController: UITableViewController {

    var usuarios : [Usuario] = []
        
    let dbManager = DBManager()
    
    var IdUsuario : Int = 0
    
    var IdRol : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
       
        tableView.reloadData()
        UdpateUI()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "UsuarioCell", bundle: .main), forCellReuseIdentifier:"UsuarioCell")
        
        
        UdpateUI()
        
    }

    //protocolos de un tableview
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usuarios.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "usuarioCell", for: indexPath)
        //        cell.textLabel?.text = usuarios[indexPath.row].ApellidoPaterno
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsuarioCell", for: indexPath) as! UsuarioCell
        
        cell.delegate = self
        cell.lblNombreOutlet.text = usuarios[indexPath.row].Nombre
        cell.lblApellidoP.text = usuarios[indexPath.row].ApellidoPaterno
//        cell.lblFechaN.text = usuarios[indexPath.row].FechaNacimiento
//        cell.lblUserNameOutlet.text = usuarios[indexPath.row].Username
        cell.lblRolOutlet.text = usuarios[indexPath.row].rol?.Nombre
        
                return cell
        }


}

extension GetAllUsuarioController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
                       

                let result =  UsuarioViewModel.Delete(IdUsuario: self.usuarios[indexPath.row].IdUsuario!)
                
                if result.Correct! {
                    print("usuario Elimnado")
                    self.UdpateUI()
                }else{
                    print("Ocurrio un error")
                }
                
            }
            return [deleteAction]
        }
        if orientation == .left {
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                
                self.IdUsuario = self.usuarios[indexPath.row].IdUsuario!
                self.performSegue(withIdentifier: "UsuarioControler", sender: self)
                
            }
            return [updateAction]
        }
        return nil

    
    }
    
    func UdpateUI(){
        var result = UsuarioViewModel.GetAll()
        usuarios.removeAll()
        if result.Correct!{
            for objUsuario in result.Objects!{
                let usuario = objUsuario as! Usuario //Unboxing
                usuarios.append(usuario)
            }
            tableView.reloadData()
           
        }
    }
    
   
    
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//        options.transitionStyle = .border
//        return options
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           //controlar que hacer antes de ir a la siguiente vista
           if segue.identifier == "UsuarioControler"{
               let formControl = segue.destination as! ViewController
               formControl.IdUsuario = self.IdUsuario
               //formControl.IdRol = Self.IdRol
               
           }
       }
}
