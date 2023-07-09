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
    var itemData = [cart]()
    
    var orderHistoryArray : [[String : Any]] = []
    
    //save card details
    var getCard = [cardDetails]()

    var ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    
    var orderRandomID = ""
    
    var NotificationBool = ""
    
    var newData = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        amountView.layer.borderWidth = 1
        amountView.layer.borderColor = UIColor.tertiaryLabel.cgColor
        readPrimary()
        
        //total amount
        self.finalAmount.text = totalFinalAmount!
        
        debugPrint("NotificationBool : \(NotificationBool)")
    }
    
    func saveDataToFirebase(for indexPath: IndexPath, handleComplete: (()->())){
        
        let randomInt = Int.random(in: 100000000000..<9999999999999)

        let randomString = String(randomInt)
        self.orderRandomID.append(randomString)
        
        let dataToSave = itemData[indexPath.row]
        let key = ref.childByAutoId().key
        
        if self.userID != nil{
            
            //getting order date
            let todayDate = Date()
            debugPrint("today Data === \(todayDate)")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd yyyy"
            
            // Convert Date to String
            let presentData = dateFormatter.string(from: todayDate)
            print("presentDate :::::: \(presentData)")
            
            
            for cart in itemData{
                let dict : [String: Any] = [
                    "bookName": cart.bookName!,
                    "authorName" : cart.authorName!,
                    "bookPrice": cart.bookPrice!,
                    "imageURL": cart.imageURL!,
                    "description": cart.description!,
                    "id": cart.id!,
                    "productStock": cart.productStock!,
                    "bookRating": cart.productStock!
                ]
                orderHistoryArray.append(dict)
            }
            
            self.ref.child("Order History").child(userID!).childByAutoId().setValue(orderHistoryArray){ (error, reference) in
                if let error = error {
                    print("Error copying data: \(error.localizedDescription)")
                } else {
                    print("Data copied successfully!")
                }
            }
            handleComplete()
        }else{
            
            for cart in itemData{
                let dict : [String: Any] = [
                    "bookName": cart.bookName!,
                    "authorName" : cart.authorName!,
                    "bookPrice": cart.bookPrice!,
                    "imageURL": cart.imageURL!,
                    "description": cart.description!,
                    "id": cart.id!,
                    "productStock": cart.productStock!,
                    "bookRating": cart.productStock!
                ]
                orderHistoryArray.append(dict)
            }
            self.ref.child("Order History").child(userID!).childByAutoId().setValue(orderHistoryArray){ (error, reference) in
                if let error = error {
                    print("Error copying data: \(error.localizedDescription)")
                } else {
                    print("Data copied successfully!")
                }
            }
            handleComplete()
        }
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
        debugPrint("notification received to delete data from cart")
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
        self.saveDataToFirebase(for: indexPath){
            
            if self.NotificationBool == "Yes"{
                self.deleteItemFromCart()
                let VC02 = storyboard?.instantiateViewController(withIdentifier: "PurchasedOrderViewController") as? PurchasedOrderViewController
                VC02?.orderID = self.orderRandomID
                navigationController?.pushViewController(VC02!, animated: true)
            }else{
                let VC02 = storyboard?.instantiateViewController(withIdentifier: "PurchasedOrderViewController") as? PurchasedOrderViewController
                VC02?.orderID = self.orderRandomID
                navigationController?.pushViewController(VC02!, animated: true)
            }

        }
    }
}
extension Notification.Name{
    static let buyNow = Notification.Name("buyNow")
}
