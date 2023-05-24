//
//  AreaController.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 23/05/23.
//

import UIKit
import SQLite3

class AreaController: UIViewController {

    @IBOutlet weak var btcAction: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    
    
    @IBOutlet weak var itemArea: UICollectionView!
    
    var area : [Area] = []
    var IdArea : Int = 0
    var Id : Int = 0
    var guardardato : String = ""
    //let dbManager = DBManger()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        itemArea.register(UINib(nibName: "AreaCell", bundle: .main), forCellWithReuseIdentifier: "AreaCell")
        itemArea.delegate = self
        itemArea.dataSource = self
        updateUI()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSearchProductos(_ sender: UIButton) {
        
        guard txtSearch.text != "" else {
            //ddletiqueta.text =  "El campo no puede ser vacio"
            txtSearch.layer.borderColor = UIColor.red.cgColor
            txtSearch.layer.borderWidth = 2
            return
        }
        guardardato = txtSearch.text!
        
        self.performSegue(withIdentifier: "segueProductosArea", sender: self)    }
    
    

}
extension AreaController :  UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return area.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCell", for: indexPath) as! AreaCell
        cell.lblNombreArea.text = area[indexPath.row].Nombre
        if area[indexPath.row].Nombre ==  area[indexPath.row].Nombre {
            cell.ImagenView.image = UIImage(named: "\(area[indexPath.row].Nombre!)")
        }else{
            //let imagenData : Data = //Proceso inverso de base64 a Data
            //cell.imageView.image = UIImage(data: imagenData)
        }
        return cell
    }
    
    func updateUI(){
        var result = AreaViewModel.GetAll()
        area.removeAll()
        if result.Correct!{
            for objarea in result.Objects!{
                let resultado = objarea as! Area //Unboxing
                area.append(resultado)
            }
            itemArea.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("seleciono \(area[indexPath.row].IdArea)")
        Id = area[indexPath.row].IdArea!
        print(Id)
        self.performSegue(withIdentifier: "SegueDepartamento", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //controlar que hacer antes de ir a la siguiente vista
        if segue.identifier == "SegueDepartamento"{
            let formControl = segue.destination as! DepartamentoController
               formControl.IdArea = Id
            
        }else{
            let formcontrol1 = segue.destination as! ProductosColeccionController
            formcontrol1.datotxt = guardardato
        }
    }
}
