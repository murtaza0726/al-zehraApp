//
//  ViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-16.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var invalidEmailText: UILabel!
    @IBOutlet var invalidPasswordText: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invalidEmailText.isEnabled = false
        invalidPasswordText.isEnabled = false
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func registerBtn(_ sender: UIButton) {
        let registerPageVC = self.storyboard?.instantiateViewController(withIdentifier: "signUpViewController") as! signUpViewController
        self.navigationController?.pushViewController(registerPageVC, animated: true)
    }
    
    @IBAction func signInBtn(_ sender: UIButton) {
        signInUserfunc()
    }
    
    //function to sign in
    func signInUserfunc(){
        Auth.auth().signIn(withEmail: emailText.text ?? "", password: passwordText.text ?? "") { firebaseResult, error in
            if let e = error {
                print(e.localizedDescription)
                print("not working")
                self.invalidEmailText.text = "Please enter valid email"
                self.invalidPasswordText.text = "Please enter valid password"
                self.invalidEmailText.isEnabled = true
                self.invalidPasswordText.isEnabled = true
                self.invalidEmailText.textColor = UIColor.red
                self.invalidPasswordText.textColor = UIColor.red
                
            }else{
                
                //navigate to app home page
                let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
                self.navigationController?.pushViewController(homePageVC, animated: true)
            }
        }
    }
}

