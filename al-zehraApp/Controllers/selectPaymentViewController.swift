//
//  selectPaymentViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-27.
//

import UIKit
import Firebase

class selectPaymentViewController: UIViewController {

    
    @IBOutlet var selectPaymentMethod: UITableView!
    @IBOutlet var otherPaymentOptionBtn: UIButton!
    @IBOutlet var amountView: UIView!
    
    @IBOutlet var finalAmount: UILabel!
    
    //getting total amount from confirm shipping controller
    var totalFinalAmount: String?
    
    //getting shipping data from confirm shipping controller
    var itemData = [Any]()
    
    //save card details
    var getCard = [cardDetails]()

    var ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    
    var orderRandomID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        amountView.layer.borderWidth = 1
        amountView.layer.borderColor = UIColor.tertiaryLabel.cgColor
        readPrimary()
        
        //total amount
        self.finalAmount.text = totalFinalAmount!
    }
    
    //save to order history
    func copyDataToDestinationNode(finished2: () -> Void) {
        
        let randomInt = Int.random(in: 100000000000..<9999999999999)
        debugPrint(randomInt)
        let randomString = String(randomInt)
        
        self.orderRandomID.append(randomString)
        
        debugPrint("****************** 4 : \(self.itemData as Any) ********************")
        
        
        self.ref.child("Order History").child(userID!).childByAutoId().setValue(itemData) { (error, reference) in
            if let error = error {
                print("Error copying data: \(error.localizedDescription)")
            } else {
                print("Data copied successfully!")
            }
        }
        finished2()
    }

    //read card details
    func readPrimary(){
        //let currentUserID = Auth.auth().currentUser?.uid
        self.ref.child("cardDetails").child(userID!).child("VISA").observe(.value, with: {(snapshot) in
                self.getCard.removeAll()
                for snap in snapshot.children.allObjects as! [DataSnapshot]{
                    let mainDict = snap.value as? [String: AnyObject]
                    let cardNumber = mainDict?["cardNumber"]
                    let cardHolder = mainDict?["cardHolder"]
                    let expiryDate = mainDict?["expiryDate"]
                    let cvv = mainDict?["cvv"]
                    
                    let users = cardDetails(cardNumber: cardNumber as! String, cardHolder: cardHolder as! String, expiryDate: expiryDate as! String, cvv: cvv as! String)
                    self.getCard.append(users)
                }
                self.selectPaymentMethod.reloadData()
            })
        }
    
    func deleteItemFromCart(){
        self.ref.child("itemList").child(userID!).setValue(nil) { (error, reference) in
            if let error = error {
                print("Error copying data: \(error.localizedDescription)")
            } else {
                print("data removed from cart after order is successful !!")
            }
        }
    }
}

//table view to show cards to complete payment
extension selectPaymentViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getCard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = selectPaymentMethod.dequeueReusableCell(withIdentifier: "selectPaymentMethodCell", for: indexPath) as! selectPaymentMethodCell
        cell.selectionStyle = .none
        self.selectPaymentMethod.separatorStyle = .none
        cell.cardNumber.text = getCard[indexPath.row].cardNumber
        cell.cardHolder.text = getCard[indexPath.row].cardHolder
        cell.cardImageCode.layer.cornerRadius = 10
        cell.cardImageCode.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.copyDataToDestinationNode{
            
            self.deleteItemFromCart()
            let VC02 = storyboard?.instantiateViewController(withIdentifier: "PurchasedOrderViewController") as? PurchasedOrderViewController
            VC02?.orderID = self.orderRandomID
            navigationController?.pushViewController(VC02!, animated: true)
        }
    }
}
