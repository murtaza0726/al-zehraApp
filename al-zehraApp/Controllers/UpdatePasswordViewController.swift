//
//  UpdatePasswordViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-05-27.
//

import UIKit

class UpdatePasswordViewController: UIViewController {

    @IBOutlet var passwordInfo: UILabel!
    @IBOutlet var userEmail: UITextField!
    @IBOutlet var currentPassword: UITextField!
    @IBOutlet var newPassword: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordInfo.text = "if you wish to change the password to access your account, please provide the following information:"
        self.userEmail.setUpUnderlineTextField2()
        self.newPassword.setUpUnderlineTextField2()
        self.currentPassword.setUpUnderlineTextField2()
        self.confirmPassword.setUpUnderlineTextField2()
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
