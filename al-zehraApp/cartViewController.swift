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
                let bookImage = mainDict?["bookImage"]
                
                let cartM = cart(bookName: bookName as! String? ?? "", authorName: authorName as! String? ?? "", bookImage: bookImage as! String? ?? "", bookPrice: bookPrice as! String? ?? "")
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! cartTableViewCell
        
        let myCart: cart
        
        myCart = cartData[indexPath.row]
        cell.bookName.text = myCart.bookName
        cell.authorName.text = myCart.authorName
        cell.bookPrice.text = myCart.bookPrice
        return cell
    }
}
