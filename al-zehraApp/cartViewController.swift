//
//  cartViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-04-29.
//

import UIKit
import Firebase
import FirebaseStorage

class cartViewController: UIViewController {
    
    
    @IBOutlet var cartTableView: UITableView!
    @IBOutlet var subTotal: UILabel!
    @IBOutlet var checkOutBtn: UIButton!
    @IBOutlet var emptyCartImage: UIImageView!
    @IBOutlet var emptyCartMsg: UILabel!
    @IBOutlet var subtotalLbl: UILabel!
    @IBOutlet var dollar: UILabel!
    
    var ref = Database.database().reference()
    
    var cartData = [cart]()
    var subTotalList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Cart"
        self.getPrice()
        self.getData()
    }
    @IBAction func checkOutBtnAction(_ sender: UIButton) {
        print("check out button pressed")
    }
    func getData(){
        self.ref.child("itemList").observe(.value, with: {(snapshot) in
            self.cartData.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let bookName = mainDict?["bookName"]
                let authorName = mainDict?["authorName"]
                let bookPrice = mainDict?["bookPrice"]
                let imageURL = mainDict?["imageURL"]
                let description = mainDict?["description"]
                let id = mainDict?["id"]
                
                let cartM = cart(bookName: bookName as! String? ?? "", id: id as! String? ?? "", authorName: authorName as! String? ?? "", bookPrice: bookPrice as! String? ?? "", imageURL: imageURL as! String? ?? "", description: description as! String? ?? "")
                self.cartData.append(cartM)
             }
            self.cartTableView.reloadData()
        })
    }
    
    func getPrice(){
        self.ref.child("itemList").observe(.value, with: {(snapshot) in
            self.subTotalList.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let bookPrice = mainDict?["bookPrice"]
                let Category = bookPrice as? String ?? ""
                self.subTotalList.append(Category)
             }
            self.cartTableView.reloadData()
            if !self.subTotalList.isEmpty{
                let arrayInt = self.subTotalList.compactMap { Double($0) }
                let total = arrayInt.reduce(0, +)
                let totalPrice = Double(total).rounded(toPlaces: 2)
                self.subTotal.text = "\(totalPrice)"
            }else{
                self.subTotal.text = "0"
            }
        })
    }
    func checkOutBtnText(){
        checkOutBtn.setTitle("Proceed to checkout (\(self.cartData.count) item)", for: .normal)
    }
    func deleteItemFromCart(id: String){
        ref.child("itemList").child(id).setValue(nil)
    }
    
    func newData(for indexPath: IndexPath){
        self.deleteItemFromCart(id: self.cartData[indexPath.row].id!)
    }
    //save data to fav
    func saveDataToFirebase(for indexPath: IndexPath, handleComplete: (()->())){
        let dataToSave = cartData[indexPath.row]
        let key = ref.childByAutoId().key
        let dict = ["id": key as Any, "bookName": (cartData[indexPath.row].bookName!), "authorName": (cartData[indexPath.row].authorName!), "bookPrice": (cartData[indexPath.row].bookPrice!), "description": (cartData[indexPath.row].description!), "imageURL": (cartData[indexPath.row].imageURL as Any)]
        self.ref.child("Fav").child(key!).setValue(dict)
        handleComplete()
    }
}

extension cartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.checkOutBtnText()
        if cartData.count == 0{
            self.emptyCartMsg.isHidden = false
            self.cartTableView.isHidden = true
            self.emptyCartImage.isHidden = false
            self.emptyCartMsg.text = "Your cart is empty !!"
            self.checkOutBtn.isHidden = true
            self.subTotal.isHidden = true
            self.subtotalLbl.isHidden = true
            self.dollar.isHidden = true
        }else{
            self.emptyCartMsg.isHidden = true
            self.cartTableView.isHidden = false
            self.emptyCartImage.isHidden = true
            self.checkOutBtn.isHidden = false
            self.subTotal.isHidden = false
            self.subtotalLbl.isHidden = false
            self.dollar.isHidden = false
            
        }
        return cartData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(250)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! cartTableViewCell
        cell.selectionStyle = .none
        let myCart: cart
        myCart = cartData[indexPath.row]
        cell.bookName.text = myCart.bookName
        cell.authorName.text = myCart.authorName
        cell.bookPrice.text = myCart.bookPrice
        cell.descrips.text = myCart.description
        
        if let url = URL(string: myCart.imageURL!){
            cell.imageURL.loadImage3(from: url)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete", handler: { _, _, _ in
            
            // create the alert
            let alert = UIAlertController(title: "Remove from cart", message: "Would you like to delete this item from cart", preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: { _ in
                self.deleteItemFromCart(id: self.cartData[indexPath.row].id!)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            print("delete pressed")
        })
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete])
        return swipeConfiguration
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = UIContextualAction(style: .normal, title: "Save for later")
        { (action, view, completion) in
            print("favorite pressed")
            self.saveDataToFirebase(for: indexPath, handleComplete: { () -> () in self.newData(for: indexPath)})
            completion(true)
        }
        let swipeFavConfiguration = UISwipeActionsConfiguration(actions: [favorite])
        return swipeFavConfiguration
    }
}

extension UIImageView{
    func loadImage3(from url: URL){
        
        let newSpinner = UIActivityIndicatorView(style: .medium)
        newSpinner.hidesWhenStopped = true
        newSpinner.center = center
        newSpinner.startAnimating()
        self.addSubview(newSpinner)
        
        
        var task: URLSessionDataTask!
        let imageCache = NSCache<AnyObject, AnyObject>()
        
        image = nil
        
        if let task = task {
            task.cancel()
        }
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        task = URLSession.shared.dataTask(with: url){(data, response, error) in
            guard
                let data = data,
                let newImage = UIImage(data: data)
            else{
                print("error")
                return
            }
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = newImage
                newSpinner.stopAnimating()
            }
        }
        task.resume()
    }
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
