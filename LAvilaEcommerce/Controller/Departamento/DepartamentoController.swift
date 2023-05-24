//
//  DepartamentoController.swift
//  LAvilaEcommerce
//
//  Created by MacBookMBA16 on 23/05/23.
//

import UIKit
import SQLite3


class DepartamentoController: UICollectionViewController {
    
    
    var departamento : [Departamento] = []

    var IdArea : Int = 0
    var Id : Int = 0
    
    
    @IBOutlet var itemdepartamento: UICollectionView!
    
   
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            collectionView.register(UINib(nibName: "AreaCell", bundle: .main), forCellWithReuseIdentifier: "AreaCell")
            itemdepartamento.delegate = self
            itemdepartamento.dataSource = self
            updateUI()
            
            print("el area es: \(IdArea)")
        }


        override func numberOfSections(in collectionView: UICollectionView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }


        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of items
            return departamento.count
        }

        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCell", for: indexPath) as! AreaCell
            cell.lblNombreArea.text = departamento[indexPath.row].Nombre
            if departamento[indexPath.row].Nombre ==  departamento[indexPath.row].Nombre {
                cell.ImagenView.image = UIImage(named: "\(departamento[indexPath.row].Nombre!)")
            }else{
               
            }
            return cell
        }


        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            Id  = departamento[indexPath.row].IdDepartamento!
            print(Id)

            self.performSegue(withIdentifier: "SeguesProductos", sender: self)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //controlar que hacer antes de ir a la siguiente vista
            if segue.identifier == "SeguesProductos"{
                let formControl = segue.destination as! ProductosColeccionController
                formControl.IdDepartamento = Id
                
            }
        }


        func updateUI(){
            var result = DepartamentoViewModel.GetbyidArea(IdArea: IdArea)
            departamento.removeAll()
            if result.Correct!{
                for objdepartamento in result.Objects!{
                    let resultado = objdepartamento as! Departamento
                    //Unboxing
                    departamento.append(resultado)
                }
                collectionView?.reloadData()
            }
        }
    }
    



