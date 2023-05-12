//
//  FormRolController.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 09/05/23.
//


import UIKit

class FormRolController : UIViewController{
    
    var IdRol : Int = 0
    
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var lblNombreEtiqueta: UILabel!
    @IBOutlet weak var lblIdEtiqueta: UILabel!
    
    @IBOutlet weak var txtidRoloutlet: UITextField!
    
    @IBOutlet weak var txtNombreOutlet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(IdRol)
        
        if IdRol == 0 {

            //self.performSegue(withIdentifier: "RolControler", sender: FormRolController.self)

            self.txtidRoloutlet.text = ""
            self.txtNombreOutlet.text = ""
           

            btnAction.backgroundColor = .green
            btnAction.setTitle("Agregar", for: .normal)

        }else{

            let rol =  RolViewModel.GetByid(IdRol: IdRol)
            //umboxing
            let acceder = rol.Object as! Rol

            self.txtidRoloutlet.text = acceder.idRol?.description
            self.txtNombreOutlet.text = acceder.Nombre
           

            btnAction.backgroundColor = .yellow
            btnAction.setTitle("Actualizar", for: .normal)

      }
    }
    
   
    @IBAction func btnguardardatos(_ sender: UIButton) {
        guard txtNombreOutlet.text != "" else {
            lblIdEtiqueta.text =  "El campo no puede ser vacio"
            txtidRoloutlet.layer.borderColor = UIColor.red.cgColor
            txtidRoloutlet.layer.borderWidth = 2
            return
        }
        
        guard txtNombreOutlet.text != "" else{
            //fatalError("El ApellidoPaterno es nulo")
            lblNombreEtiqueta.text = "El campo no puede ser vacio"
            txtNombreOutlet.layer.borderColor = UIColor.red.cgColor
            txtNombreOutlet.layer.borderWidth = 2
            return
        }
        
        let opcion = btnAction.titleLabel?.text
        switch opcion{
        case "Agregar":
            var rol = Rol()
            
            rol.Nombre = txtNombreOutlet.text!
           
            
            let result = RolViewModel.Add(rol: rol)
            if result.Correct! {
                let alert = UIAlertController(title: "Mensaje", message: "Rol Agregado correctamente", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                txtNombreOutlet.text = ""
           
            }
            break
        case "Actualizar":
            var rol = Rol()
            
            rol.idRol = Int(txtidRoloutlet.text!) ?? 0
            rol.Nombre = txtNombreOutlet.text!

        
            
            let result = RolViewModel.Update(rol: rol)
            if result.Correct! {
                let alert = UIAlertController(title: "Mensaje", message: "Usuario actualizado correctamente", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                txtidRoloutlet.text = ""
                txtNombreOutlet.text = ""
            }
            break
        default:
            print("No se realizo nada")
        }
        
    }
        
    
    
        
    
    
}
