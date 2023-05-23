//
//  ViewController.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 27/04/23.
//

import UIKit
import iOSDropDown

class ViewController: UIViewController {
   
    let imagenpicker : UIImagePickerController = UIImagePickerController()
    
    
    @IBOutlet weak var lblPasswordEtiqueta: UILabel!
    @IBOutlet weak var lblUsernameEtiqueta: UILabel!
    @IBOutlet weak var lblFechaEtiqueta: UILabel!
    @IBOutlet weak var lblApellidoMEtiqueta: UILabel!
    
    @IBOutlet weak var txtIdRol: DropDown!
    
    @IBOutlet weak var lblApellidoPEtiqueta: UILabel!
    @IBOutlet weak var lbNombreEtiqueta: UILabel!
    
    @IBOutlet weak var btnAction: UIButton!
    
    @IBOutlet weak var txtIdOutlet: UITextField!
    
    @IBOutlet weak var txtNombreOutlet: UITextField!
    
    @IBOutlet weak var txtApellidoPOutlet: UITextField!
    
    @IBOutlet weak var txtApellidoMOutlet: UITextField!

    
    @IBOutlet weak var txtFechaNacimiento: UITextField!
    //@IBOutlet weak var DatePickerfecha: UIDatePicker!
    
    @IBOutlet weak var txtUserNameOutlet: UITextField!

    @IBOutlet weak var txtPasswordOutlet: UITextField!
    
    @IBOutlet weak var txtIdRolOutlet: UITextField!
    
    var dbManager : DBManager? = nil
    
    var IdUsuario : Int = 0
    
    var IdRol : Int = 0
    

    
    override func viewDidLoad() {
        //gaurdadmos el id del dropdwon
        txtIdRol.didSelect{selectedText , index ,id in
        self.IdRol = id
            }
        super.viewDidLoad()
        
        //imagenpicker.delegate = self
        
        txtIdRol.optionArray = []

        txtIdRol.optionIds = []
       
        let resultRol = RolViewModel.GetAll()
        if resultRol.Correct!{
            for objrol in resultRol.Objects!{
                let rol = objrol as! Rol
                //agregamos los datos de la bd en los arrays
                txtIdRol.optionArray.append(rol.Nombre!)
                txtIdRol.optionIds?.append(rol.idRol!)
            }
    
            
        }

                print(IdUsuario)

        if IdUsuario == 0 {
            
            //self.performSegue(withIdentifier: "UsuarioControler1", sender: ViewController.self)
            
            self.txtIdOutlet.text = ""
            self.txtNombreOutlet.text = ""
            self.txtApellidoPOutlet.text = ""
            self.txtApellidoMOutlet.text = ""
            self.txtFechaNacimiento.text = ""
            self.txtUserNameOutlet.text = ""
            self.txtPasswordOutlet.text = ""
            
            
            btnAction.backgroundColor = .green
            btnAction.setTitle("Agregar", for: .normal)
            
        }else{
            
            let usuario =  UsuarioViewModel.GetById(IdUsuario: IdUsuario)
            //umboxing
            let acceder = usuario.Object as! Usuario
    
            
            
            self.txtIdOutlet.text = acceder.IdUsuario?.description
            self.txtNombreOutlet.text = acceder.Nombre
            self.txtApellidoPOutlet.text = acceder.ApellidoPaterno
            self.txtApellidoMOutlet.text = acceder.ApellidoMaterno
            self.txtFechaNacimiento.text = acceder.FechaNacimiento
            self.txtUserNameOutlet.text = acceder.Username
            self.txtPasswordOutlet.text = acceder.Password
            //self.txtIdOutlet.text = acceder.rol?.Nombre
            self.txtIdRol.text = acceder.rol?.Nombre
        
            btnAction.backgroundColor = .yellow
            btnAction.setTitle("Actualizar", for: .normal)

        }
    }

    
//    @IBAction func btnUpdateDAtosAction(_ sender: UIButton) {
//
//
//    }
    
//    @IBAction func btnDeleteAction(_ sender: UIButton) {
//
//        var IdUsuario = Int(txtIdOutlet.text!) ?? 0
//
//        UsuarioViewModel.Delete(IdUsuario : IdUsuario)
//
//    }
    
    
    @IBAction func btnRecuperarDatosAction() {
        
        
//        guard txtIdOutlet.text != "" else {
//            fatalError("El Id es nulo")
//            return
//        }
        
        guard txtNombreOutlet.text != "" else {
            lbNombreEtiqueta.text =  "El campo no puede ser vacio"
            txtNombreOutlet.layer.borderColor = UIColor.red.cgColor
            txtNombreOutlet.layer.borderWidth = 2
            return
        }
        
        guard txtApellidoPOutlet.text != "" else{
            //fatalError("El ApellidoPaterno es nulo")
            lblApellidoPEtiqueta.text = "El campo no puede ser vacio"
            txtApellidoPOutlet.layer.borderColor = UIColor.red.cgColor
            txtApellidoPOutlet.layer.borderWidth = 2
            return
        }
        guard txtApellidoMOutlet.text != "" else{
            //fatalError("El ApellidoMaterno es nulo")
            lblApellidoMEtiqueta.text = "El campo no puede ser vacio"
            txtApellidoMOutlet.layer.borderColor = UIColor.red.cgColor
            txtApellidoMOutlet.layer.borderWidth = 2
            return
        }
        guard txtFechaNacimiento.text != "" else{
            lblFechaEtiqueta.text = "El campo no puede ser vacio"
            txtFechaNacimiento.layer.borderColor = UIColor.red.cgColor
            txtFechaNacimiento.layer.borderWidth = 2
            return
        }
        guard txtUserNameOutlet.text != "" else{
            //fatalError("El username es nulo")
            lblUsernameEtiqueta.text = "El campo no puede ser vacio"
            txtUserNameOutlet.layer.borderColor = UIColor.red.cgColor
            txtUserNameOutlet.layer.borderWidth = 2
            return
        }
        guard txtPasswordOutlet.text != "" else{
            //fatalError("El Password es nulo")
            lblPasswordEtiqueta.text = "El campo no puede ser vacio"
            return
        }
        let opcion = btnAction.titleLabel?.text
        switch opcion{
        case "Agregar":
            var usuario = Usuario()
            
            usuario.Nombre = txtNombreOutlet.text!
            usuario.ApellidoPaterno = txtApellidoPOutlet.text!
            usuario.ApellidoMaterno = txtApellidoMOutlet.text!
            usuario.FechaNacimiento = txtFechaNacimiento.text!
            usuario.Username = txtUserNameOutlet.text!
            usuario.Password = txtPasswordOutlet.text!
            usuario.rol = Rol()
            usuario.rol?.idRol = self.IdRol
            
            let result = UsuarioViewModel.Add(usuario: usuario)
            if result.Correct! {
                let alert = UIAlertController(title: "Mensaje", message: "Uusuario Agregado correctamente", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                txtNombreOutlet.text! = ""
                txtApellidoPOutlet.text! = ""
                txtApellidoMOutlet.text! = ""
                txtFechaNacimiento.text! = ""
                txtUserNameOutlet.text! = ""
                txtPasswordOutlet.text! = ""
                txtIdRol.text! = ""
                
                
            }
            break
        case "Actualizar":
            var usuario = Usuario()
            
            usuario.IdUsuario = Int(txtIdOutlet.text!) ?? 0
            usuario.Nombre = txtNombreOutlet.text!
            usuario.ApellidoPaterno = txtApellidoPOutlet.text!
            usuario.ApellidoMaterno = txtApellidoMOutlet.text!
            usuario.FechaNacimiento = txtFechaNacimiento.text!
            usuario.Username = txtUserNameOutlet.text!
            usuario.Password = txtPasswordOutlet.text!
            usuario.rol = Rol()
            //usuario.rol?.idRol = Int(txtIdRolOutlet.text!) ?? 0
            usuario.rol?.idRol = self.IdRol

            
            let result = UsuarioViewModel.Update(usuario: usuario)
            if result.Correct! {
                let alert = UIAlertController(title: "Mensaje", message: "Usuario actualizado correctamente", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                txtNombreOutlet.text! = ""
                txtApellidoPOutlet.text! = ""
                txtApellidoMOutlet.text! = ""
                txtFechaNacimiento.text! = ""
                txtUserNameOutlet.text! = ""
                txtPasswordOutlet.text! = ""
                txtIdRol.text! = ""
            }
            break
        default:
            print("No se realizo nada")
        }
    }
    
    
    
    
}


