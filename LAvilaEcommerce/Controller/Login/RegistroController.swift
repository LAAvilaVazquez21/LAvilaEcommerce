//
//  RegistroController.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 22/05/23.
//

import UIKit
import Firebase

class RegistroController: UIViewController {
    
    @IBOutlet weak var usuarioTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    @IBOutlet weak var ddlEtUsuario: UILabel!
    
    
    @IBOutlet weak var password2Txt: UITextField!
    
    @IBOutlet weak var dllEtPassword: UILabel!
    
    @IBOutlet weak var ddlEtPassword2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func btnregistrar(_ sender: UIButton) {
        
        guard usuarioTxt.text != "" else {
            ddlEtUsuario.text =  "El campo no puede ser vacio"
            usuarioTxt.layer.borderColor = UIColor.red.cgColor
            usuarioTxt.layer.borderWidth = 2
            return
        }
        
        guard passwordTxt.text != "" else{
            //fatalError("El ApellidoPaterno es nulo")
            dllEtPassword.text = "El campo no puede ser vacio"
            passwordTxt.layer.borderColor = UIColor.red.cgColor
            passwordTxt.layer.borderWidth = 2
            return
        }
        guard password2Txt.text != "" else{
            //fatalError("El ApellidoPaterno es nulo")
            ddlEtPassword2.text = "El campo no puede ser vacio"
            password2Txt.layer.borderColor = UIColor.red.cgColor
            password2Txt.layer.borderWidth = 2
            return
        }
        
        
        guard passwordTxt.text == password2Txt.text else{
            //fatalError("El ApellidoPaterno es nulo")
            ddlEtPassword2.text = "No coinciden las contraseñas"
            passwordTxt.layer.borderColor = UIColor.red.cgColor
            passwordTxt.layer.borderWidth = 2
            return
        }

        let correo = usuarioTxt.text!
        let contraseña = passwordTxt.text!
        
        Auth.auth().createUser(withEmail: correo, password: contraseña){ [weak self] authResult, error in
            guard let strongSelf = self else{return}
            
            
            if let correct = authResult{
                
                let alert = UIAlertController(title: "Mensaje", message: "Usuario Registrado", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self!.present(alert, animated: true, completion: nil)
                
                self!.usuarioTxt.text! = ""
                self!.passwordTxt.text! = ""
                self!.password2Txt.text! = ""
                
                
                
            }
            self?.performSegue(withIdentifier: "tapbarregistar", sender: self)
        }
        
        
    }
}
