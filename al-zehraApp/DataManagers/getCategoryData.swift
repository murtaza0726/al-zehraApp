//
//  getCategoryData.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-17.
//

import Foundation
import UIKit
import Firebase

class getData{
    
    var ref = Database.database().reference()
            
    func getFourDataFromDB(finished: () -> Void){
        self.ref.child("Offers").observe(.value, with: {(snapshot) in
            BookManager.offersAd2.removeAll()
            //self.offersAd.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let title = mainDict?["title"]
                let headerImage = mainDict?["headerImage"]
                let Category = OffersModel(title: title as! String? ?? "", headerImage: headerImage as! String? ?? "")
                //BookManager.offersAd.append(Category)
                BookManager.offersAd2.append(Category)

             }
            //self.bestSellerCollectionView.reloadData()
        })
        finished()
    }
}
