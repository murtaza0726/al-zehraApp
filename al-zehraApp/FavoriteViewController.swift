//
//  FavoriteViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-05-17.
//

import UIKit
import Firebase

class FavoriteViewController: UIViewController {

    
    var ref = Database.database().reference()
    var FavData = [Favorite]()
    
    @IBOutlet var favTable: UITableView!
    @IBOutlet var emptyCartMsg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite"
        self.getFav()
    }
    func getFav(){
        self.ref.child("Fav").observe(.value, with: {(snapshot) in
            self.FavData.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                    let bookName = mainDict?["bookName"]
                    let authorName = mainDict?["authorName"]
                    let bookPrice = mainDict?["bookPrice"]
                    let imageURL = mainDict?["imageURL"]
                    let description = mainDict?["description"]
                    let id = mainDict?["id"]
                    
                    let cartM = Favorite(bookName: bookName as! String? ?? "", id: id as! String? ?? "", authorName: authorName as! String? ?? "", bookPrice: bookPrice as! String? ?? "", imageURL: imageURL as! String? ?? "", description: description as! String? ?? "")
                    self.FavData.append(cartM)
                }
            self.favTable.reloadData()
        })
    }
    func deleteItemFromFav(id: String){
        ref.child("Fav").child(id).setValue(nil)
    }
    
    func newData2(for indexPath: IndexPath){
        self.deleteItemFromFav(id: self.FavData[indexPath.row].id!)
    }
    
    //save data to fav
    func saveDataToCart(for indexPath: IndexPath, handleComplete: (()->())){
        let dataToSave = FavData[indexPath.row]
        let key = ref.childByAutoId().key
        let dict = ["id": key as Any, "bookName": (FavData[indexPath.row].bookName!), "authorName": (FavData[indexPath.row].authorName!), "bookPrice": (FavData[indexPath.row].bookPrice!), "description": (FavData[indexPath.row].description!), "imageURL": (FavData[indexPath.row].imageURL as Any)]
        self.ref.child("itemList").child(key!).setValue(dict)
        handleComplete()
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        let myFav: Favorite
        myFav = FavData[indexPath.row]
        
        cell.bookName.text = myFav.bookName
        cell.authorName.text = myFav.authorName
        cell.bookPrice.text = myFav.bookPrice
        cell.descrips.text = myFav.description
        
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
