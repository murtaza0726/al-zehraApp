//
//  EmailViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-05-25.
//

import UIKit
import Firebase

class EmailViewController: UIViewController {
    
    
    @IBOutlet var currentEmailLabel: UILabel!
    @IBOutlet weak var floatingTextField: UITextField!
    @IBOutlet var newEmail: UITextField!
    @IBOutlet var confirmNewEmail: UITextField!
    
    let ref = Database.database().reference()
    var userEmail = [userDetails]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.currentEmailLabel.text = "Your current email address is : "
        floatingTextField.setUpUnderlineTextField()
        self.newEmail.setUpUnderlineTextField()
        self.confirmNewEmail.setUpUnderlineTextField()
        self.getDataFromDB()
    }
    func getDataFromDB(){
        self.ref.child("userDetails").observe(.value, with: {(snapshot) in
            self.userEmail.removeAll()
            let currentUserID = Auth.auth().currentUser?.uid
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
                if currentUserID == userKey {
                    //self.userEmail.append(users)
                    self.currentEmailLabel?.text = "Your current email address is : \((users.email).prefix(1).capitalized + (users.email).dropFirst())"
                    self.floatingTextField.text = ((users.email).prefix(1).capitalized + (users.email).dropFirst())
                }else{
                    self.currentEmailLabel?.text = "Error"
                    print("failed to get the user email ID from Firebase")
                }
             }
        })
    }
    func updateEmail(){
        self.ref.child("userDetails").observe(.value, with:{(snapshot) in
            self.userEmail.removeAll()
            let currenUserID = Auth.auth().currentUser?.uid
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let userKey = snap.key
                if currenUserID == userKey{
                    let dictEmail = ["email":self.confirmNewEmail.text!]
                    self.ref.child("userDetails").child(userKey).setValue(dictEmail)
                }
            }
        })
    }
    
    @IBAction func updateEmail(_ sender: UIButton) {
        self.updateEmail()
    }
}
extension UIView{
    func setUpUnderlineTextField(){
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width - 15, height: 0.5)
        bottomLayer.backgroundColor = UIColor.gray.cgColor
        self.layer.addSublayer(bottomLayer)
    }
}
