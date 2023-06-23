//
//  NewReleaseViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-20.
//

import UIKit

class NewReleaseViewController: UIViewController {

    
    var oneBookDetail2: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = oneBookDetail2
        print("oneBookDetail2: \(oneBookDetail2!)")
    }
}
