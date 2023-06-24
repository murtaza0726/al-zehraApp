//
//  getSpecificData.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-24.
//

import Foundation
import UIKit
import Firebase

class getSpecificData{
    
    var ref = Database.database().reference()
    
    var userData = [bookList]()
    
    func getBookData(){
        
        let databaseRef = Database.database().reference().child("Popular")
        let query = databaseRef.queryOrdered(byChild: "title").queryStarting(atValue: NewReleaseViewController().oneBookDetail2).queryEnding(atValue: "\(NewReleaseViewController().oneBookDetail2))\\uf8ff")
        query.observeSingleEvent(of: .value){(snapshot) in
            guard snapshot.exists() != false else
            {
                print("data not found")
                return
            }
            print(snapshot.value as Any)
            DispatchQueue.main.async {
                guard let dict = snapshot.value as? [String:AnyObject] else {
                    print(snapshot)
                    return
                }
                let title = dict["title"]
                let author = dict["author"]
                let description = dict["description"]
                let price = dict["price"]
                let imageURL = dict["imageURL"]
                let productStock = dict["productStock"]
                let productRating = dict["productRating"]
                
                let Category = bookList(title: title as! String? ?? "",
                                        author: author as! String? ?? "",
                                        description: description as! String? ?? "",
                                        price: price as! String? ?? "",
                                        imageURL: imageURL as! String? ?? "",
                                        productStock: productStock as! String? ?? "",
                                        productRating: productRating as! String? ?? "")
                self.userData.append(Category)
                //print(Category.title)
            }
            //print(self.userData)
        }
        print(self.userData)
    }
    
    /*
    func getDataFromDB(finished: () -> Void){
        self.ref.child("Offers").observe(.value, with: {(snapshot) in
            self.userData.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let title = mainDict?["title"]
                let author = mainDict?["author"]
                let description = mainDict?["description"]
                let price = mainDict?["price"]
                let imageURL = mainDict?["imageURL"]
                let productStock = mainDict?["productStock"]
                let productRating = mainDict?["productRating"]
                let Category = bookList(title: title as! String? ?? "",
                                        author: author as! String? ?? "",
                                        description: description as! String? ?? "",
                                        price: price as! String? ?? "",
                                        imageURL: imageURL as! String? ?? "",
                                        productStock: productStock as! String? ?? "",
                                        productRating: productRating as! String? ?? "")

                self.userData.append(Category)
                print(Category.title)

             }
            //self.bestSellerCollectionView.reloadData()
            print("offData4: \(self.userData)")
        })
        finished()
    }
    */
}
