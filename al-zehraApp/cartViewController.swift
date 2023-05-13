//
//  cartViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-04-29.
//

import UIKit
import Firebase

class cartViewController: UIViewController {
    
    
    @IBOutlet var cartTableView: UITableView!
    
    var ref = Database.database().reference()
    
    var cartData = [cart]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Cart"
        self.getData()
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
                
                let cartM = cart(bookName: bookName as! String? ?? "", authorName: authorName as! String? ?? "", bookPrice: bookPrice as! String? ?? "", imageURL: imageURL as! String? ?? "", description: description as! String? ?? "")
                self.cartData.append(cartM)
             }
            self.cartTableView.reloadData()
        })
    }
}

extension cartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(250)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! cartTableViewCell
        
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
}

extension UIImageView{
    func loadImage3(from url: URL){
        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            guard
                let data = data,
                let newImage = UIImage(data: data)
            else{
                print("error")
                return
            }
            DispatchQueue.main.async {
                self.image = newImage
            }
        }
        task.resume()
    }
}
