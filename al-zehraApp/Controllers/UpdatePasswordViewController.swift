//
//  UpdatePasswordViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-05-27.
//

import UIKit
import Firebase

class UpdatePasswordViewController: UIViewController {

    @IBOutlet var passwordInfo: UILabel!
    @IBOutlet var userEmail: UITextField!
    @IBOutlet var currentPassword: UITextField!
    @IBOutlet var newPassword: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    
    let ref = Database.database().reference()
    var userEmail2 = [userDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordInfo.text = "if you wish to change the password to access your account, please provide the following information:"
        self.userEmail.setUpUnderlineTextField2()
        self.newPassword.setUpUnderlineTextField2()
        self.currentPassword.setUpUnderlineTextField2()
        self.confirmPassword.setUpUnderlineTextField2()
        getDataFromDB()
    }
    
    
    @IBAction func changePasswordBtn(_ sender: UIButton) {
        
        updatePassword{
            //action sheet
            let actionSheet = UIAlertController(title: "Password Updated", message: "Your password has been updated successfully", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(actionSheet, animated: true)
        }
    }
    
    func getDataFromDB(){
        let currentUserID = Auth.auth().currentUser?.uid
        self.ref.child("userDetails").child(currentUserID!).observe(.value, with: {(snapshot) in
            self.userEmail2.removeAll()
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
                    self.userEmail?.text = "\((users.email).prefix(1).capitalized + (users.email).dropFirst())"
                }else{
                    self.userEmail?.text = "Error"
                    print("failed to get the user email ID from Firebase")
                }
             }
        })
    }
    
    func updatePassword(finished: () -> Void){
        let currentUserID = Auth.auth().currentUser?.uid
        let userEmail = Auth.auth().currentUser?.email
        let currentUser = Auth.auth().currentUser
        if currentPassword.text != nil && newPassword.text != nil && confirmPassword.text != nil {
            self.ref.child("userDetails").child(currentUserID!).child("primaryDetails").updateChildValues(["password": confirmPassword.text!])
            if confirmPassword.text != userEmail{
                currentUser?.updateEmail(to: confirmPassword.text!){error in
                    if let error = error{
                        print(error)
                    }
                    else{
                        print("changed")
                    }
                }
            }
            finished()
        }
    }
}
extension UIView{
    func setUpUnderlineTextField2(){
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width - 15, height: 0.5)
        bottomLayer.backgroundColor = UIColor.gray.cgColor
        self.layer.addSublayer(bottomLayer)
    }
}
