//
//  LoginController.swift
//  LAvilaEcommerceVenta
//
//  Created by MacBookMBA16 on 25/05/23.
//

import UIKit
import Firebase

class LoginController: UIViewController {

   
    @IBOutlet weak var lbluser: UILabel!
    
    
    @IBOutlet weak var lblpassword: UILabel!
    

    @IBOutlet weak var textpassword: UITextField!
    
    @IBOutlet weak var textuser: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btcagregarusuario(_ sender: Any) {
        
        performSegue(withIdentifier: "segueagregar", sender: self)
    }
    
    @IBAction func btciniciarsesion(_ sender: Any) {
        
        guard textuser.text != "" else {
            lbluser.text =  "El campo no puede ser vacio"
            textuser.layer.borderColor = UIColor.red.cgColor
            textuser.layer.borderWidth = 2
            return
        }
        
        guard textpassword.text != "" else{
            //fatalError("El ApellidoPaterno es nulo")
            lblpassword.text = "El campo no puede ser vacio"
            textpassword.layer.borderColor = UIColor.red.cgColor
            textpassword.layer.borderWidth = 2
            return
            
        }
        
        let correo = textuser.text!
        let contraseña = textpassword.text!
        
        Auth.auth().signIn(withEmail: correo, password: contraseña) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            
            if let ex = error{
                let alert = UIAlertController(title: "Mensaje", message: "No se encontro su usuario", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self!.present(alert, animated: true, completion: nil)
                self!.textuser.text! = ""
                self!.textpassword.text! = ""
            }
            if let correct = authResult{
              
                self?.performSegue(withIdentifier: "LoginController", sender: self)
            }
            
        }
    }
   

}
