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
    
    var cardD = [cardDetails]()
    
    var onePaymentType: paymentMethod?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardNumber.setUpUnderlineTextField6()
        self.expiryDate.setUpUnderlineTextField6()
        self.cardHolderName.setUpUnderlineTextField6()
        self.securityCode.setUpUnderlineTextField6()
        createDatePicker()
        print(onePaymentType?.paymentName)
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
        self.checkCard2{
            checkArray()
        }
    }
    func addCard(){
        let userID = Auth.auth().currentUser?.uid
        let dict2 = ["cardNumber": self.cardNumber.text!, "cardHolder" : self.cardHolderName.text!, "expiryDate": self.expiryDate.text!, "cvv":self.securityCode.text!]
        
        self.ref.child("cardDetails").child(userID!).child("\(self.onePaymentType?.paymentName ?? "card")").childByAutoId().setValue(dict2)
    }
    func checkCard2(finished: () -> Void){
        print("start")
        let currentUserID = Auth.auth().currentUser?.uid
        self.ref.child("cardDetails").child(currentUserID!).observe(.value, with: {(snapshot) in
            self.cardD.removeAll()
            if snapshot.exists(){
                for snap in snapshot.children.allObjects as! [DataSnapshot]{
                    print("cardType: \(snap.key)")
                    for snaps in snap.children.allObjects as! [DataSnapshot]{
                        let userKeys = snaps.key
                        print("key: \(userKeys)")
                        let mainDict = snaps.value as? [String: AnyObject]
                        let cardNumber = mainDict?["cardNumber"]
                        let cardHolder = mainDict?["cardHolder"]
                        let expiryDate = mainDict?["expiryDate"]
                        let cvv = mainDict?["cvv"]
                        
                        
                        let users = cardDetails(cardNumber: cardNumber as! String, cardHolder: cardHolder as! String, expiryDate: expiryDate as! String, cvv: cvv as! String)
                        print(users.cardNumber)
                        
                        self.cardD.append(users)
                        //self.checkArray()
                    }
                    
                }
                
            }
            else{
                print("data not there, create new")
            }
        })
        finished()
    }
    
    func checkArray(){
        if cardD.contains(where: { $0.cardNumber == self.cardNumber.text! }){
            print("card found")
            let actionSheet = UIAlertController(title: "Card Exist", message: "Please try to add another card", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(actionSheet, animated: true)
        }
        else{
            print("card not found")
            addCard()
        }
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
