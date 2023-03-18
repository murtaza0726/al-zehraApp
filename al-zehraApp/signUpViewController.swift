//
//  signUpViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-16.
//

import UIKit
import Firebase

class signUpViewController: UIViewController {

    
    @IBOutlet var fNameText: UITextField!
    @IBOutlet var LastNameText: UITextField!
    @IBOutlet var phoneNumText: UITextField!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    
    var ref = DatabaseReference.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        
    }
    
    @IBAction func signUpBtn(_ sender: UIButton) {
        self.saveData()
    }
    
    func saveData(){
        let dict = ["firstName":fNameText.text!, "LastName":LastNameText.text!, "phone":phoneNumText.text!, "email":emailText.text!, "password":passwordText.text!]
        self.ref.child("userDetails").childByAutoId().setValue(dict)
    }
}
