//
//  cardDataViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-12.
//

import UIKit
import Firebase

class cardDataViewController: UIViewController {
    
    let ref = Database.database().reference()
    
    @IBOutlet var cardNumber: UITextField!
    @IBOutlet var expiryDate: UITextField!
    @IBOutlet var cardHolderName: UITextField!
    @IBOutlet var securityCode: UITextField!
    
    let datePicker = UIDatePicker()
    
    let currentUserID = Auth.auth().currentUser?.uid
    
    var twoPaymentType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardNumber.setUpUnderlineTextField6()
        self.expiryDate.setUpUnderlineTextField6()
        self.cardHolderName.setUpUnderlineTextField6()
        self.securityCode.setUpUnderlineTextField6()
        createDatePicker()
        self.view.addSubview(datePicker)
        print("onePaymentType2 : \(twoPaymentType)")
    }
    
    func createToolBar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let toolBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneBtn))
        toolbar.setItems([toolBtn], animated: true)
        return toolbar
    }
    
    func createDatePicker(){
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        datePicker.datePickerMode  = .date
        expiryDate.inputView = datePicker
        expiryDate.inputAccessoryView = createToolBar()

    }
    
    @objc func doneBtn(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self.expiryDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func saveCard(_ sender: UIButton) {
        print("btn save card")
        checkCard2{
            addCard{
            }
        }
    }
    func addCard(finishedCard: () -> Void){
        let dict2 = ["cardNumber": self.cardNumber.text!, "cardHolder" : self.cardHolderName.text!, "expiryDate": self.expiryDate.text!, "cvv":self.securityCode.text!]
        
        self.ref.child("cardDetails").child(currentUserID!).child("\(twoPaymentType)").child("\(self.cardNumber.text!)").setValue(dict2)
        finishedCard()
    }
    
    func checkCard2(finished: () -> Void ){
        print("twoPaymentType : \(twoPaymentType)")
        self.ref.child("cardDetails").child(currentUserID!).child("\(twoPaymentType)").queryOrdered(byChild: "cardNumber").queryEqual(toValue: self.cardNumber.text!).observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.exists(){
                print("duplicate")
                let actionSheet = UIAlertController(title: "Card Exist", message: "Please try to add another card", preferredStyle: .actionSheet)
                                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(actionSheet, animated: true)
            }

        })
        print("data not there, create new")
        finished()
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



