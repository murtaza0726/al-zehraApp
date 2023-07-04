//
//  OrderHistoryViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-07-03.
//

import UIKit
import Firebase

class OrderHistoryViewController: UIViewController {

    
    @IBOutlet var orderHistoryTableView: UITableView!
    
    var orderHistory = [cart]()
    
    let userKey = Auth.auth().currentUser?.uid
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserData()
    }
    
    
    
    func getUserData(){
        print("userKey order history = \(userKey!)")
            self.ref.child("Order History/\(userKey!)/").observe(.value, with: {(snapshot) in
                for snap in snapshot.children.allObjects as! [DataSnapshot]{
                    let userKey2 = snap.key
                    self.ref.child("Order History/\(self.userKey!)/\(userKey2)").observe(.value, with: {(snapshot2) in
                        self.orderHistory.removeAll()
                        for snap2 in snapshot2.children.allObjects as! [DataSnapshot]{
                            print("user key from order history = \(userKey2)")
                            let mainDict = snap2.value as? [String: AnyObject]
                            print("mainDict Order History = \(mainDict)")
                            let bookName = mainDict?["bookName"]
                            let authorName = mainDict?["authorName"]
                            let bookPrice = mainDict?["bookPrice"]
                            let imageURL = mainDict?["imageURL"]
                            let description = mainDict?["description"]
                            let id = mainDict?["id"]
                            let productStock = mainDict?["productStock"]
                            let bookRating = mainDict?["bookRating"]
                            let cartM = cart(bookName: bookName as! String? ?? "", id: id as! String? ?? "", authorName: authorName as! String? ?? "", bookPrice: bookPrice as! String? ?? "", imageURL: imageURL as! String? ?? "", description: description as! String? ?? "", productStock: productStock as! String? ?? "", bookRating: bookRating as! String? ?? "")
                            self.orderHistory.append(cartM)
                            debugPrint("orderHistory in order history page: \(self.orderHistory)")
                        }
                        self.orderHistoryTableView.reloadData()
                    })
                    
                }
            })
        }
}
extension OrderHistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        debugPrint("orderHistory.count ========= \(orderHistory.count)")
        return orderHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderHistoryTableView.dequeueReusableCell(withIdentifier: "OrderHistoryTableViewCell", for: indexPath) as! OrderHistoryTableViewCell
        
        cell.bookName.text = orderHistory[indexPath.row].bookName
        if let url = URL(string: orderHistory[indexPath.row].imageURL!){
            cell.imageURL.loadImage20(from: url)
        }
        return cell
    }
    
    
}
extension UIImageView{
    func loadImage20(from url: URL){
        
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
