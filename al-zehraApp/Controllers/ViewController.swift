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
    
    @IBOutlet var errorTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.invalidEmailText.isHidden = true
        self.invalidPasswordText.isHidden = true
        self.errorTextLabel.isHidden = true
        self.emailText.setUpUnderlineTextField3()
        self.passwordText.setUpUnderlineTextField3()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func registerBtn(_ sender: UIButton) {
        let registerPageVC = self.storyboard?.instantiateViewController(withIdentifier: "signUpViewController") as! signUpViewController
        self.navigationController?.pushViewController(registerPageVC, animated: true)
        print(registerPageVC)
        print("register btn pressed")
    }
    
    @IBAction func signInBtn(_ sender: UIButton) {
        signInUserfunc()
    }
    
    //function to sign in
    func signInUserfunc(){
        Auth.auth().signIn(withEmail: emailText.text ?? "", password: passwordText.text ?? "") { firebaseResult, error in
            if let e = error {
                print(e.localizedDescription)
                let error = e.localizedDescription
                if self.emailText.text == "" && self.passwordText.text == "" && error == e.localizedDescription && error == "The password is invalid or the user does not have a password."{
                    self.invalidEmailText.isHidden = false
                    self.invalidEmailText.text = "This field is mandatory"
                    
                    self.invalidPasswordText.isHidden = false
                    self.invalidPasswordText.text = "This field is mandatory"
                }
                if self.emailText.text != "" && self.passwordText.text == "" && error == e.localizedDescription && error == "The password is invalid or the user does not have a password."{
                    self.invalidEmailText.isHidden = true
                    
                    self.invalidPasswordText.isHidden = false
                    self.invalidPasswordText.text = "This field is mandatory"
                }
                if self.emailText.text == "" && self.passwordText.text != "" && error == e.localizedDescription && error == "The email address is badly formatted."
                {
                    self.invalidEmailText.isHidden = false
                    self.invalidEmailText.isEnabled = true
                    self.invalidEmailText.text = "This field is mandatory"
                    
                    self.invalidPasswordText.isHidden = true
                }
                if error == e.localizedDescription &&
                    error == "There is no user record corresponding to this identifier. The user may have been deleted."
                {
                    //action sheet
                    let actionSheet = UIAlertController(title: "User not found", message: "There is no user record corresponding to this identifier. The user may have been deleted.", preferredStyle: .actionSheet)
                    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(actionSheet, animated: true)
                }
                if error == e.localizedDescription && error == "The password is invalid or the user does not have a password."{
                    let actionSheet = UIAlertController(title: "Invalid Password", message: "The password is invalid or the user does not have a password.", preferredStyle: .actionSheet)
                    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(actionSheet, animated: true)
                }
                if error == e.localizedDescription && error == "Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later."{
                    let actionSheet = UIAlertController(title: "Account Locked", message: "Reset your password or try again after sometime.", preferredStyle: .actionSheet)
                    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(actionSheet, animated: true)
                }
            }else{
                NotificationCenter.default.post(name: .userLoggedIn, object: nil)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
extension UIView{
    func setUpUnderlineTextField3(){
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width - 15, height: 0.5)
        bottomLayer.backgroundColor = UIColor.gray.cgColor
        self.layer.addSublayer(bottomLayer)
    }
}
