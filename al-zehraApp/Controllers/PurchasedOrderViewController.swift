//
//  PurchasedOrderViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-30.
//

import UIKit
import Firebase

class PurchasedOrderViewController: UIViewController {

    var orderID = ""
    var getAddress = [userDetails]()
    
    @IBOutlet var orderId: UILabel!
    @IBOutlet var estimatedArrivalDate: UILabel!
    @IBOutlet var userAddress: UILabel!
    @IBOutlet var postalCity: UILabel!
    @IBOutlet var phoneNumber: UILabel!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomInt2 = Int.random(in: 1..<7)
        
        //order date
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: randomInt2, to: today)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy"
        let dateString = dateFormatter.string(from: tomorrow!)
        
        self.orderId.text = orderID
        self.estimatedArrivalDate.text =  dateString
        self.getUserPrimaryAddress()
    }
    
    func getUserPrimaryAddress(){
        let currentUserID = Auth.auth().currentUser?.uid
        self.ref.child("userDetails").child(currentUserID!).observe(.value, with: {(snapshot) in
            self.getAddress.removeAll()
            
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let userKey = snap.key
                let mainDict = snap.value as? [String: AnyObject]
                let firstName = mainDict?["firstName"]
                let LastName = mainDict?["LastName"]
                let phone = mainDict?["phone"]
                let password = mainDict?["password"]
                let userUID = mainDict?["userUID"]
                let email = mainDict?["email"]
                let addressLine1 = mainDict?["addressLine1"]
                let addressLine2 = mainDict?["addressLine2"]
                let postalCode = mainDict?["postalCode"]
                let city = mainDict?["city"]
                
                
                let users = userDetails(firstName: firstName as! String, LastName: LastName as! String, phone: phone as! String, email: email as! String, password: password as! String, userUID: userUID as! String, addressLine1: addressLine1 as! String, addressLine2: addressLine2 as! String, postalCode: postalCode as! String, city: city as! String)
                
                if userKey == "primaryDetails" {
                    self.getAddress.append(users)
                    self.userAddress.text = users.addressLine1 + ", " + users.addressLine2
                    self.postalCity.text = users.postalCode + " " + users.city
                    self.phoneNumber.text = users.phone
                }else{
                    print("nokkkkkkkkk")
                }
             }
            //self.userAddressTableView.reloadData()
        })
    }
}
