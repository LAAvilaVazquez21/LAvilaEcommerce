//
//  GetAllRolController.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 09/05/23.
//

import UIKit
import SwipeCellKit


class GetAllRolController: UITableViewController {

    var rol : [Rol] = []
    
    var IdRol : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        //UdpateUI()
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RolCell", bundle: .main), forCellReuseIdentifier:"RolCell")
        updateUI()
    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rol.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "RolCell", for: indexPath) as! RolCell
     

        
//        cell.delegate = self
//        cell.lblIdRol.text = rol[indexPath.row].idRol?.description
//        cell.lblNombreRol.text = rol[indexPath.row].Nombre
        

        return cell
    }
   

}



extension GetAllRolController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
                
                
                let result =  RolViewModel.Delete(idrol: self.rol[indexPath.row].idRol!)
                
                if result.Correct! {
                    print("Rol Elimnado")
                    self.updateUI()
                }else{
                    print("Ocurrio un error")
                }
                
            }
            return [deleteAction]
        }
        if orientation == .left {
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                
                self.IdRol = self.rol[indexPath.row].idRol!
                self.performSegue(withIdentifier: "RolControler", sender: self)
                
            }
            return [updateAction]
        }
        return nil
        
        
    }
    
    func updateUI(){
        var result = RolViewModel.GetAll()
        rol.removeAll()
        if result.Correct!{
            for objRol in result.Objects!{
                let roles = objRol as! Rol //Unboxing
                rol.append(roles)
            }
            tableView.reloadData()
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //controlar que hacer antes de ir a la siguiente vista
        if segue.identifier == "RolController"{
            let formControl = segue.destination as! FormRolController
            formControl.IdRol = self.IdRol
            
        }
    }
}
