import UIKit

private let reuseIdentifier = "Cell"

class ProductosColeccionController: UICollectionViewController {
    
    let carritoViewModel = CarritoViewModel()
    var producto : [Producto] = []
    
    var IdDepartamento : Int = 0
    var Id : Int = 0
    var datotxt : String = ""
    
    @IBOutlet var itemprod: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "ProductosCardCell", bundle: .main), forCellWithReuseIdentifier: "ProductosCardCell")
        itemprod.delegate = self
        itemprod.dataSource = self
        
        
        print("el area es: \(IdDepartamento)")
        print("el area es: \(datotxt)")
        
        if IdDepartamento == 0{
            
            var result = ProductosViewModelLike.GetbAllProducto(Sentencia: datotxt)
            producto.removeAll()
            if result.Correct!{
                for objdepartamento in result.Objects!{
                    let resultado = objdepartamento as! Producto
                    //Unboxing
                    producto.append(resultado)
                }
                collectionView?.reloadData()
            }
            
        }else{
            
            var result = ProductosCardViewModel.GetbAllProducto(IdDepartamento: IdDepartamento)
            producto.removeAll()
            if result.Correct!{
                for objdepartamento in result.Objects!{
                    let resultado = objdepartamento as! Producto
                    //Unboxing
                    producto.append(resultado)
                }
                collectionView?.reloadData()
            }
        }
        
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return producto.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductosCardCell", for: indexPath) as! ProductosCardCell
        
        cell.lblnombre.text = producto[indexPath.row].Nombre
        cell.lblprecio.text = producto[indexPath.row].PrecioUnitario?.description
        cell.lblDescripcio.text = producto[indexPath.row].Descripcion
        
        if producto[indexPath.row].imagen == "" || producto[indexPath.row].imagen == nil {
            cell.imagenView.image = UIImage(named: "DefaultProducto")
        }else{
            let string =  producto[indexPath.row].imagen
            
            
            let newImageData = Data(base64Encoded: string!)
            if let newImageData = newImageData {
                cell.imagenView.image = UIImage(data: newImageData)
            }
        }
        cell.btnGuardaDato.tag = indexPath.row
        cell.btnGuardaDato.addTarget(self, action: #selector(AddCarrito), for: .touchUpInside)
        
        return cell
        
    }
    
    @objc func AddCarrito(sender : UIButton){
    
        
        let AddProducto = producto[sender.tag].IdProducto!
        
        let result = carritoViewModel.Add(AddProducto)
                if result.Correct! {
                    let alert = UIAlertController(title: "Mensaje", message: "Se agrego el producto", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }else{
                    
                    let alert = UIAlertController(title: "Mensaje", message: "No se agrego el producto", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                carritoViewModel.GetAll()
            }
    
    
}


