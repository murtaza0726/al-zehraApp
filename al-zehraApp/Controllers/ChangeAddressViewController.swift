//
//  ChangeAddressViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-11.
//

import UIKit
import Firebase

class ChangeAddressViewController: UIViewController {

    let ref = Database.database().reference()
    var userEmail = [userDetails]()
    
    @IBOutlet var addressLine1: UITextField!
    @IBOutlet var addressLine2: UITextField!
    @IBOutlet var postalCode: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addressLine1.setUpUnderlineTextField5()
        self.addressLine2.setUpUnderlineTextField5()
        self.postalCode.setUpUnderlineTextField5()
        self.city.setUpUnderlineTextField5()
        self.phoneNumber.setUpUnderlineTextField5()
        
        self.getDataFromDB()
    }
    
    
    @IBAction func updateAddressBtn(_ sender: Any) {
        updateAddress{
            //action sheet
            let actionSheet = UIAlertController(title: "User Details Updated", message: "Your details has been saved successfully", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(actionSheet, animated: true)
        }
    }
    
    func updateAddress(finished: () -> Void){
        let currentUser = Auth.auth().currentUser
        let currentUserID = currentUser?.uid
        let userEmail = currentUser?.email
        if addressLine1.text != nil && addressLine2.text != nil && postalCode.text != nil && city.text != nil && phoneNumber.text != nil {
            self.ref.child("userDetails").child(currentUserID!).child("primaryDetails").updateChildValues(["addressLine1": addressLine1.text!, "addressLine2": addressLine2.text!, "postalCode": postalCode.text!, "city": city.text!, "phone": phoneNumber.text!])
            finished()
        }
    }
    
    func getDataFromDB(){
        let currentUserID = Auth.auth().currentUser?.uid
        self.ref.child("userDetails").child(currentUserID!).observe(.value, with: {(snapshot) in
            self.userEmail.removeAll()
            
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let userKey = snap.key
                if currentUserID == userKey {
                    print("userThred : " + userKey)
                }
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
                    //self.userEmail.append(users)
                    self.addressLine1?.text = "\((users.addressLine1).prefix(1).capitalized + (users.addressLine1).dropFirst())"
                    self.addressLine2.text = ((users.addressLine2).prefix(1).capitalized + (users.addressLine2).dropFirst())
                    self.postalCode.text = ((users.postalCode).prefix(1).capitalized + (users.postalCode).dropFirst())
                    self.phoneNumber.text = ((users.phone).prefix(1).capitalized + (users.phone).dropFirst())
                    self.city.text = ((users.city).prefix(1).capitalized + (users.city).dropFirst())
                }else{
                    self.addressLine2?.text = "Error"
                    print("failed to get the user email ID from Firebase")
                }
             }
        })
    }
}
extension UIView{
    func setUpUnderlineTextField5(){
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width - 15, height: 0.5)
        bottomLayer.backgroundColor = UIColor.gray.cgColor
        self.layer.addSublayer(bottomLayer)
    }
}
