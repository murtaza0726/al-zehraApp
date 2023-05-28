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
                print("not working")
                self.invalidEmailText.text = "Please enter valid email"
                self.invalidPasswordText.text = "Please enter valid password"
                self.invalidEmailText.isEnabled = true
                self.invalidPasswordText.isEnabled = true
                self.invalidEmailText.textColor = UIColor.red
                self.invalidPasswordText.textColor = UIColor.red
                
            }else{
                
                let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: "userPage") as! userInfoPageViewController
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
