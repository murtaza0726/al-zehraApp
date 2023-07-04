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
    @IBOutlet var subtotalBtnView: UIView!
    
    
    var url_ratingZero = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-0.png?alt=media&token=684078e0-e930-4fc8-a53b-56f804cf07f2"
    var url_ratingOne = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-1.png?alt=media&token=b370a027-91c0-433d-a9b1-9269e000b8df"
    var url_ratingTwo = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-2.png?alt=media&token=d5c77cf2-3a03-4547-929f-28649f623755"
    var url_ratingThree = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-3.png?alt=media&token=a853915e-13e6-4c36-9e2c-e381cad6d44e"
    var url_ratingFour = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-4.png?alt=media&token=15af6f97-28c7-48b3-9cca-60f99cebf890"
    var url_ratingFive = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-5.png?alt=media&token=121f8391-ee19-40bf-8db2-1c973deb3dcf"
    
    
    var ref = Database.database().reference()
    let userKey = Auth.auth().currentUser?.uid
    
    var cartData = [cart]()
    var subTotalList = [String]()
    
    var cartDataToShipping = [Any]()
    
    var ImageURL2 = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cart"
        //self.getPrice()
        
        subtotalBtnView.layer.borderWidth = 2
        subtotalBtnView.layer.borderColor = UIColor.tertiaryLabel.cgColor
        
        if self.userKey != nil{
            self.getUserData()
            self.getUserPrice()
        }else{
            self.getDefaultUserData()
            self.getDefaultUserPrice()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(getDefaultUserData), name: .userLoggedOut, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getDefaultUserPrice), name: .userLoggedOut, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getUserData), name: .userLoggedIn, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getUserPrice), name: .userLoggedIn, object: nil)
    }
    
    //conitnue button - cart
    @IBAction func checkOutBtnAction(_ sender: UIButton) {
        
        let vc4 = storyboard?.instantiateViewController(withIdentifier: "confirmShippingViewController") as? confirmShippingViewController
        
        vc4?.amountTotal = self.subTotal.text!
        vc4?.dummyData = self.cartDataToShipping
        vc4?.orderConfirmImage2 = self.cartData
        
        NotificationCenter.default.post(name: .proccedToBuy, object: nil)
        
        navigationController?.pushViewController(vc4!, animated: true)
    }
    
    // get data from firebase to display in table view for logged in user
    @objc func getUserData(){
            self.ref.child("itemList/\(userKey!)").observe(.value, with: {(snapshot) in
                self.cartData.removeAll()
                self.cartDataToShipping.removeAll()
                for snap in snapshot.children.allObjects as! [DataSnapshot]{
                    let mainDict = snap.value as? [String: AnyObject]
                    let bookName = mainDict?["bookName"]
                    let authorName = mainDict?["authorName"]
                    let bookPrice = mainDict?["bookPrice"]
                    let imageURL = mainDict?["imageURL"]
                    let description = mainDict?["description"]
                    let id = mainDict?["id"]
                    let productStock = mainDict?["productStock"]
                    let bookRating = mainDict?["bookRating"]
                    let cartM = cart(bookName: bookName as! String? ?? "", id: id as! String? ?? "", authorName: authorName as! String? ?? "", bookPrice: bookPrice as! String? ?? "", imageURL: imageURL as! String? ?? "", description: description as! String? ?? "", productStock: productStock as! String? ?? "", bookRating: bookRating as! String? ?? "")
                    self.cartData.append(cartM)
                    self.cartDataToShipping.append(mainDict as Any)
                }
                self.cartTableView.reloadData()
            })
        }
    
    // get data from firebase to display in table view for default user
    @objc func getDefaultUserData(){
        self.ref.child("itemList/defaultUser").observe(.value, with: {(snapshot) in
            self.cartData.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let bookName = mainDict?["bookName"]
                let authorName = mainDict?["authorName"]
                let bookPrice = mainDict?["bookPrice"]
                let imageURL = mainDict?["imageURL"]
                let description = mainDict?["description"]
                let id = mainDict?["id"]
                let productStock = mainDict?["productStock"]
                let bookRating = mainDict?["bookRating"]
                let cartM = cart(bookName: bookName as! String? ?? "", id: id as! String? ?? "", authorName: authorName as! String? ?? "", bookPrice: bookPrice as! String? ?? "", imageURL: imageURL as! String? ?? "", description: description as! String? ?? "", productStock: productStock as! String? ?? "", bookRating: bookRating as! String? ?? "")
                self.cartData.append(cartM)
            }
            self.cartTableView.reloadData()
        })
    }
    
    // get price to calculate total cart amount for logged in user
    @objc func getUserPrice(){
            self.ref.child("itemList/\(userKey!)").observe(.value, with: {(snapshot) in
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
                    self.subTotal.text = "$ \(totalPrice)"
                }else{
                    self.subTotal.text = "0"
                }
            })
    }
    
    // get price to calculate total cart amount for default user
    @objc func getDefaultUserPrice(){
        self.ref.child("itemList/defaultUser").observe(.value, with: {(snapshot) in
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
    
    // button to check out the items from cart
    func checkOutBtnText(){
        checkOutBtn.setTitle("Proceed to checkout (\(self.cartData.count) item)", for: .normal)
    }
    
    //swipe left func to delete items from cart
    func deleteItemFromCart(id: String){
        if self.userKey != nil{
            ref.child("itemList/\(userKey!)").child(id).setValue(nil)
        }else{
            ref.child("itemList/defaultUser").child(id).setValue(nil)
        }
        
    }
    
    func newData(for indexPath: IndexPath){
        self.deleteItemFromCart(id: self.cartData[indexPath.row].id!)
    }
    
    //save data to fav
    func saveDataToFirebase(for indexPath: IndexPath, handleComplete: (()->())){
        let dataToSave = cartData[indexPath.row]
        let key = ref.childByAutoId().key
        if self.userKey != nil{
            let dict = ["id": key as Any, "bookName": (dataToSave.bookName!), "authorName": (dataToSave.authorName!), "bookPrice": (dataToSave.bookPrice!), "description": (dataToSave.description!), "bookRating": (dataToSave.bookRating!),"productStock":(dataToSave.productStock!), "imageURL": (dataToSave.imageURL as Any)]
            self.ref.child("Fav/\(userKey!)").child(key!).setValue(dict)
            handleComplete()
        }else{
            let dict = ["id": key as Any, "bookName": (dataToSave.bookName!), "authorName": (dataToSave.authorName!), "bookPrice": (dataToSave.bookPrice!), "description": (dataToSave.description!), "bookRating": (dataToSave.bookRating!),"productStock":(dataToSave.productStock!), "imageURL": (dataToSave.imageURL as Any)]
            self.ref.child("Fav/defaultUser").child(key!).setValue(dict)
            handleComplete()
        }
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
            self.subtotalBtnView.isHidden = true
            self.subTotal.isHidden = true
            self.subtotalLbl.isHidden = true
        }else{
            self.emptyCartMsg.isHidden = true
            self.cartTableView.isHidden = false
            self.emptyCartImage.isHidden = true
            self.checkOutBtn.isHidden = false
            self.subtotalBtnView.isHidden = false
            self.subTotal.isHidden = false
            self.subtotalLbl.isHidden = false
            
        }
        return cartData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(250)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! cartTableViewCell
        self.cartTableView.separatorStyle = .none
        cell.selectionStyle = .none
        let myCart: cart
        myCart = cartData[indexPath.row]
        cell.bookName.text = myCart.bookName
        cell.authorName.text = myCart.authorName
        cell.bookPrice.text = myCart.bookPrice
        cell.descrips.text = myCart.description
        cell.productStock.text = myCart.productStock
        cell.productRating.text = myCart.bookRating
        
        

        
        if myCart.bookRating == "N/A"{
            if let urlZero = URL(string: url_ratingZero){
                cell.productRatingImage.loadImage3(from: urlZero)
            }
        }
        if myCart.bookRating == "1.0"{
            if let urlOne = URL(string: url_ratingOne){
                cell.productRatingImage.loadImage3(from: urlOne)
            }
        }
        if myCart.bookRating == "2.0"{
            if let urlTwo = URL(string: url_ratingTwo){
                cell.productRatingImage.loadImage3(from: urlTwo)
            }
        }
        if myCart.bookRating == "3.0"{
            if let urlThree = URL(string: url_ratingThree){
                cell.productRatingImage.loadImage3(from: urlThree)
            }
        }
        if myCart.bookRating == "4.0"{
            if let urlFour = URL(string: url_ratingFour){
                cell.productRatingImage.loadImage3(from: urlFour)
            }
        }
        if myCart.bookRating == "5.0"{
            if let urlFive = URL(string: url_ratingFive){
                cell.productRatingImage.loadImage3(from: urlFive)
            }
        }
        
        
        if myCart.productStock == "In Stock"{
            cell.productStock.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 2.0)
        }
        if myCart.productStock == "Out of Stock"{
            cell.productStock.textColor = .red
        }
        if let url = URL(string: myCart.imageURL!){
            cell.imageURL.loadImage3(from: url)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete", handler: { _, _, _ in
            
            //action sheet
            let actionSheet = UIAlertController(title: "Remove from cart", message: "Would you like to delete this item from cart", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
                guard let _ = self else{
                    return
                }
                do {
                    self!.deleteItemFromCart(id: self!.cartData[indexPath.row].id!)
                }
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(actionSheet, animated: true)
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
