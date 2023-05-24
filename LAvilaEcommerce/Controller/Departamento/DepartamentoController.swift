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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "AreaCell", bundle: .main), forCellWithReuseIdentifier: "AreaCell")
//        itemDepartamento.delegate = self
//        itemDepartamento.dataSource = self
        //        updateUI()
        
        print(IdArea)
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


}

extension DepartamentoController :  UICollectionViewDelegate{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let Id : Int = departamento[indexPath.row].IdDepartamento!
        print(Id)
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
    



