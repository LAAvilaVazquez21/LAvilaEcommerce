//
//  RegistroController.swift
//  LAvilaEcommerceVenta
//
//  Created by MacBookMBA16 on 26/05/23.
//

import UIKit
import Firebase

class RegistroController: UIViewController {
    
    @IBOutlet weak var txtvalidarpassword1: UITextField!
    
    @IBOutlet weak var txtvalidaruser: UITextField!
    
    @IBOutlet weak var txtvalidarpassword2: UITextField!
    
    @IBOutlet weak var lbluser: UILabel!

    @IBOutlet weak var lblpassword1: UILabel!
    
    @IBOutlet weak var lblpassword2: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func ntcagregaruser(_ sender: UIButton) {
        
        guard txtvalidaruser.text != "" else {
            lbluser.text =  "El campo no puede ser vacio"
            txtvalidaruser.layer.borderColor = UIColor.red.cgColor
            txtvalidaruser.layer.borderWidth = 2
            return
        }
        
        guard txtvalidarpassword1.text != "" else{
            //fatalError("El ApellidoPaterno es nulo")
            lblpassword1.text = "El campo no puede ser vacio"
            txtvalidarpassword1.layer.borderColor = UIColor.red.cgColor
            txtvalidarpassword1.layer.borderWidth = 2
            return
        }
        guard txtvalidarpassword2.text != "" else{
            //fatalError("El ApellidoPaterno es nulo")
            lblpassword2.text = "El campo no puede ser vacio"
            txtvalidarpassword2.layer.borderColor = UIColor.red.cgColor
            txtvalidarpassword2.layer.borderWidth = 2
            return
        }
        
        
        guard txtvalidarpassword1.text == txtvalidarpassword2.text else{
            //fatalError("El ApellidoPaterno es nulo")
            lblpassword2.text = "No coinciden las contraseñas"
            txtvalidarpassword1.layer.borderColor = UIColor.red.cgColor
            txtvalidarpassword1.layer.borderWidth = 2
            return
        }

        let correo = txtvalidaruser.text!
        let contraseña = txtvalidarpassword1.text!
        
        Auth.auth().createUser(withEmail: correo, password: contraseña){ [weak self] authResult, error in
            guard let strongSelf = self else{return}
            
            
            if let correct = authResult{
                
                let alert = UIAlertController(title: "Mensaje", message: "Usuario Registrado", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self!.present(alert, animated: true, completion: nil)
                
                self!.txtvalidaruser.text! = ""
                self!.txtvalidarpassword1.text! = ""
                self!.txtvalidarpassword2.text! = ""
                
                
                
            }
            self?.performSegue(withIdentifier: "tapbarregistar", sender: self)
        }
        
    }
    

}
