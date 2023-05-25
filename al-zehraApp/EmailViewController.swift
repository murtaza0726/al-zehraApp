//
//  EmailViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-05-25.
//

import UIKit

class EmailViewController: UIViewController {
    
    
    @IBOutlet var currentEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentEmailLabel.text = "Your current email address is : "
    }
}
