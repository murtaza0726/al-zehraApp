//
//  ViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registerBtn(_ sender: UIButton) {
        let registerPageVC = self.storyboard?.instantiateViewController(withIdentifier: "signUpViewController") as! signUpViewController
        self.navigationController?.pushViewController(registerPageVC, animated: true)
    }
    
}

