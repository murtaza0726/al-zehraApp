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
    
    var totalFinalAmount: String?
    var itemData = [cart]()
    
    
    var ref = Database.database().reference()
    
    var getCard = [cardDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(getCard)

        amountView.layer.borderWidth = 1
        amountView.layer.borderColor = UIColor.tertiaryLabel.cgColor
        
        readPrimary()
        
        //debugPrint("check data : \(itemData[cart]["authorName"])")
        print(itemData)
        
        self.finalAmount.text = totalFinalAmount!
        debugPrint("itemData == \(itemData)")
    }


    
    
    func readPrimary(){
        let currentUserID = Auth.auth().currentUser?.uid
        self.ref.child("cardDetails").child(currentUserID!).child("VISA").observe(.value, with: {(snapshot) in
                self.getCard.removeAll()
                for snap in snapshot.children.allObjects as! [DataSnapshot]{
                    let mainDict = snap.value as? [String: AnyObject]
                    let cardNumber = mainDict?["cardNumber"]
                    let cardHolder = mainDict?["cardHolder"]
                    let expiryDate = mainDict?["expiryDate"]
                    let cvv = mainDict?["cvv"]
                    
                    let users = cardDetails(cardNumber: cardNumber as! String, cardHolder: cardHolder as! String, expiryDate: expiryDate as! String, cvv: cvv as! String)
                    print(users.cardNumber)
                    self.getCard.append(users)
                }
                self.selectPaymentMethod.reloadData()
            })
        }
    
//    func saveData(){
//        let userID = Auth.auth().currentUser?.uid
//
//        let dict2 = [
//            "authorName": itemData["authorName"],
//            "bookName": itemData["bookName"],
//            "bookPrice": itemData["bookPrice"],
//            "bookRating": itemData["bookRating"],
//            "description":itemData["description"],
//            "userUID": userID,
//            "imageURL": itemData["imageURL"],
//            "productStock": itemData["productStock"]
//        ]
//        self.ref.child("userDetails").child(userID!).child("orderHistory").setValue(dict2)
//    }
}

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
        //self.saveData()
        debugPrint("order history created")
    }
}
extension UIView{
    func setUpUnderlineTextField10(){
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width - 15, height: 0.5)
        bottomLayer.backgroundColor = UIColor.gray.cgColor
        self.layer.addSublayer(bottomLayer)
    }
}
