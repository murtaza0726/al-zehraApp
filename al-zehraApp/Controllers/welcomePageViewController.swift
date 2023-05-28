//
//  welcomePageViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-04-23.
//

import UIKit

class welcomePageViewController: UIViewController {

    
    @IBOutlet var signInBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func signInBtnAction(_ sender: UIButton) {
        let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(homePageVC, animated: true)
        print("btn pressed")
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
        let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: "signUpViewController") as! signUpViewController
        self.navigationController?.pushViewController(homePageVC, animated: true)
        print("btn pressed")
    }
    
}
