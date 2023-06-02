//
//  LoginController.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 22/05/23.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    @IBOutlet weak var ddlusuario: UILabel!
    
    @IBOutlet weak var btniniciar: UIButton!
    
    @IBOutlet weak var ddlpassword: UILabel!
    
    
    @IBOutlet weak var usuarioTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // btniniciar.isEnabled = false
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnRegistrarUsuario(_ sender: Any) {
//        btnRegistrarUsuario("Crash")
//          fatalError("Crash was triggered")
        
        performSegue(withIdentifier: "segueregistro", sender: self)
        
    }
    
    
    
    @IBAction func btnlogging() {
        
      
        
        guard usuarioTxt.text != "" else {
            ddlusuario.text =  "El campo no puede ser vacio"
            usuarioTxt.layer.borderColor = UIColor.red.cgColor
            usuarioTxt.layer.borderWidth = 2
            return
        }
        
        guard passwordTxt.text != "" else{
            //fatalError("El ApellidoPaterno es nulo")
            ddlpassword.text = "El campo no puede ser vacio"
            passwordTxt.layer.borderColor = UIColor.red.cgColor
            passwordTxt.layer.borderWidth = 2
            return
            
        }
        
        let correo = usuarioTxt.text!
        let contraseña = passwordTxt.text!
        
        Auth.auth().signIn(withEmail: correo, password: contraseña) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            
            if let ex = error{
                let alert = UIAlertController(title: "Mensaje", message: "No se encontro su usuario", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self!.present(alert, animated: true, completion: nil)
                self!.usuarioTxt.text! = ""
                self!.passwordTxt.text! = ""
            }
            if let correct = authResult{
                self?.btniniciar.isEnabled = true
                self?.performSegue(withIdentifier: "LoginController", sender: self)
            }
            
        }
        
        
    }
    
}
