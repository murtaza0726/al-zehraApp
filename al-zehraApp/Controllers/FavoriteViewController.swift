//
//  FavoriteViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-05-17.
//

import UIKit
import Firebase

class FavoriteViewController: UIViewController {

    var url_ratingZero = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-0.png?alt=media&token=684078e0-e930-4fc8-a53b-56f804cf07f2"
    var url_ratingOne = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-1.png?alt=media&token=b370a027-91c0-433d-a9b1-9269e000b8df"
    var url_ratingTwo = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-2.png?alt=media&token=d5c77cf2-3a03-4547-929f-28649f623755"
    var url_ratingThree = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-3.png?alt=media&token=a853915e-13e6-4c36-9e2c-e381cad6d44e"
    var url_ratingFour = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-4.png?alt=media&token=15af6f97-28c7-48b3-9cca-60f99cebf890"
    var url_ratingFive = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-5.png?alt=media&token=121f8391-ee19-40bf-8db2-1c973deb3dcf"
    
    
    var ref = Database.database().reference()
    var FavData = [Favorite]()
    
    @IBOutlet var favTable: UITableView!
    @IBOutlet var emptyCartMsg: UIImageView!
    
    @IBOutlet var emptyFavMsg: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite"
        self.getFav()
    }
    func getFav(){
        let userKey = Auth.auth().currentUser?.uid
        if userKey != nil{
            self.ref.child("Fav/\(userKey!)").observe(.value, with: {(snapshot) in
                self.FavData.removeAll()
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
                    
                    let cartM = Favorite(bookName: bookName as! String? ?? "", id: id as! String? ?? "", authorName: authorName as! String? ?? "", bookPrice: bookPrice as! String? ?? "", imageURL: imageURL as! String? ?? "", description: description as! String? ?? "", productStock: productStock as! String? ?? "", bookRating: bookRating as! String? ?? "")
                        self.FavData.append(cartM)
                    }
                self.favTable.reloadData()
            })
        }else{
            self.ref.child("Fav/defaultUser").observe(.value, with: {(snapshot) in
                self.FavData.removeAll()
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
                    
                    let cartM = Favorite(bookName: bookName as! String? ?? "", id: id as! String? ?? "", authorName: authorName as! String? ?? "", bookPrice: bookPrice as! String? ?? "", imageURL: imageURL as! String? ?? "", description: description as! String? ?? "", productStock: productStock as! String? ?? "", bookRating: bookRating as! String? ?? "")
                        self.FavData.append(cartM)
                    }
                self.favTable.reloadData()
            })
        }
    }
    func deleteItemFromFav(id: String){
        let userKey = Auth.auth().currentUser?.uid
        if userKey != nil{
            ref.child("Fav/\(userKey!)").child(id).setValue(nil)
        }else{
            ref.child("Fav/defaultUser").child(id).setValue(nil)
        }
    }
    
    func newData2(for indexPath: IndexPath){
        self.deleteItemFromFav(id: self.FavData[indexPath.row].id!)
    }
    
    //save data to back to cart
    func saveDataToCart(for indexPath: IndexPath, handleComplete: (()->())){
        let dataToSave = FavData[indexPath.row]
        let key = ref.childByAutoId().key
        let userKey = Auth.auth().currentUser?.uid
        let dict = ["id": key as Any, "bookName": dataToSave.bookName!, "authorName": dataToSave.authorName!, "bookPrice": dataToSave.bookPrice!, "description": dataToSave.description!,"productStock": dataToSave.productStock!,"bookRating": dataToSave.bookRating!, "imageURL": dataToSave.imageURL as Any]
        if userKey != nil {
            self.ref.child("itemList/\(userKey!)").child(key!).setValue(dict)
            handleComplete()
        }else{
            self.ref.child("itemList/defaultUser").child(key!).setValue(dict)
            handleComplete()
            
        }
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if FavData.count == 0{
            self.emptyCartMsg.isHidden = false
            self.favTable.isHidden = true
            self.emptyFavMsg.isHidden = false
            self.emptyFavMsg.text = "Your wishlist is empty !!"
        }else{
            self.emptyCartMsg.isHidden = true
            self.favTable.isHidden = false
            self.emptyFavMsg.isHidden = true
        }
        return FavData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(250)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete", handler: { _, _, _ in
            
            // create the alert
            let alert = UIAlertController(title: "Remove from Favorite", message: "Would you like to delete this item from Favorite", preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: { _ in
                self.deleteItemFromFav(id: self.FavData[indexPath.row].id!)
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
        let favorite = UIContextualAction(style: .normal, title: "Move to cart")
        { (action, view, completion) in
            print("favorite pressed")
            self.saveDataToCart(for: indexPath, handleComplete: { () -> () in self.newData2(for: indexPath)})
            completion(true)
        }
        let swipeFavConfiguration = UISwipeActionsConfiguration(actions: [favorite])
        return swipeFavConfiguration
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favTable.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavoriteTableViewCell
        cell.selectionStyle = .none
        self.favTable.separatorStyle = .none
        let myFav: Favorite
        myFav = FavData[indexPath.row]
        
        cell.bookName.text = myFav.bookName
        cell.authorName.text = myFav.authorName
        cell.bookPrice.text = myFav.bookPrice
        cell.descrips.text = myFav.description
        cell.productStock.text = myFav.productStock
        cell.bookRating.text = myFav.bookRating
        if myFav.bookRating == "N/A"{
            if let urlZero = URL(string: url_ratingZero){
                cell.bookRatingImage.loadImage4(from: urlZero)
            }
        }
        if myFav.bookRating == "1.0"{
            if let urlOne = URL(string: url_ratingOne){
                cell.bookRatingImage.loadImage4(from: urlOne)
            }
        }
        if myFav.bookRating == "2.0"{
            if let urlTwo = URL(string: url_ratingTwo){
                cell.bookRatingImage.loadImage4(from: urlTwo)
            }
        }
        if myFav.bookRating == "3.0"{
            if let urlThree = URL(string: url_ratingThree){
                cell.bookRatingImage.loadImage4(from: urlThree)
            }
        }
        if myFav.bookRating == "4.0"{
            if let urlFour = URL(string: url_ratingFour){
                cell.bookRatingImage.loadImage4(from: urlFour)
            }
        }
        if myFav.bookRating == "5.0"{
            if let urlFive = URL(string: url_ratingFive){
                cell.bookRatingImage.loadImage4(from: urlFive)
            }
        }
        
        if myFav.productStock == "In Stock"{
            cell.productStock.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 2.0)
        }
        if myFav.productStock == "Out of Stock"{
            cell.productStock.textColor = .red
        }
        if let url = URL(string: myFav.imageURL!){
            cell.imageURL.loadImage4(from: url)
        }
        return cell
    }
}
extension UIImageView{
    func loadImage4(from url: URL){
        
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
