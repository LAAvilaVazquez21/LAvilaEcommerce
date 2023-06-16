//
//  RolGetAllController.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 10/05/23.
//

import UIKit
import SwipeCellKit

class RolGetAllController: UIViewController {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var rol : [Rol] = []
    
    var IdRol : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        tableview.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       tableview.register(UINib(nibName: "RolCell", bundle: .main), forCellReuseIdentifier:"RolCell")
        
        tableview.delegate = self
        tableview.dataSource = self
        
      
        
        updateUI()
    }
}


//MARK: TABLEVIEW
extension RolGetAllController :UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        self.rol.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RolCell", for: indexPath) as! RolCell
       
        cell.delegate = self
        
        cell.lblidrol.text = rol[indexPath.row].idRol?.description
        cell.lblnombre.text = rol[indexPath.row].Nombre
        UITableView.automaticDimension
        
        return cell
    }
}



//MARK: SWIPECELLKIT
extension RolGetAllController : SwipeTableViewCellDelegate{
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
            
            tableview.reloadData()
            
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           //controlar que hacer antes de ir a la siguiente vista
           if segue.identifier == "RolControler"{
               let formControl = segue.destination as! FormRolController
               formControl.IdRol = self.IdRol
               
           }
       }
 
   
    
}



    



