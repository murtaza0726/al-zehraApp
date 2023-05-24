//
//  userAddressViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-05-23.
//

import UIKit
import Firebase

class userAddressViewController: UIViewController {
    
    @IBOutlet var userAddressTableView: UITableView!
    
    let ref = Database.database().reference()
    var userAddress = [userDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDataFromDB()
    }
    
    func getDataFromDB(){
        self.ref.child("userDetails").observe(.value, with: {(snapshot) in
            self.userAddress.removeAll()
            let currentUserID = Auth.auth().currentUser?.uid
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let userKey = snap.key
                print("userThred : " + userKey)
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
                if currentUserID == userKey {
                    self.userAddress.append(users)
                }else{
                    print("nokkkkkkkkk")
                }
             }
            self.userAddressTableView.reloadData()
        })
    }
}
extension userAddressViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userAddressTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! userAddressTableViewCell
        let myAddress: userDetails
        myAddress = userAddress[indexPath.row]
        cell.userName.text = (myAddress.firstName) + " " + (myAddress.LastName)
        cell.userAddress.text = (myAddress.addressLine1) + " " + (myAddress.addressLine2) + " " + (myAddress.postalCode) + " " + (myAddress.city)
        cell.userPhone.text = myAddress.phone
        return cell
    }
}
