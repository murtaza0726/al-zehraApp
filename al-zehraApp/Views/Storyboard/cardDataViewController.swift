//
//  cardDataViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-12.
//

import UIKit

class cardDataViewController: UIViewController {

    
    @IBOutlet var cardNumber: UITextField!
    @IBOutlet var expiryDate: UITextField!
    @IBOutlet var cardHolderName: UITextField!
    @IBOutlet var securityCode: UITextField!
    
    
    var onePaymentType: paymentMethod?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardNumber.setUpUnderlineTextField6()
        self.expiryDate.setUpUnderlineTextField6()
        self.cardHolderName.setUpUnderlineTextField6()
        self.securityCode.setUpUnderlineTextField6()
    }

}

extension UIView{
    func setUpUnderlineTextField6(){
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width - 15, height: 0.5)
        bottomLayer.backgroundColor = UIColor.gray.cgColor
        self.layer.addSublayer(bottomLayer)
    }
}
