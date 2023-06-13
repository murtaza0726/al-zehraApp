//
//  userCardsViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-13.
//

import UIKit
import Firebase

class userCardsViewController: UIViewController {

    
    @IBOutlet var cardListTableView: UITableView!
    
    var ref = Database.database().reference()
    var cardListData = [cardDetails]()
    var onePaymentType: paymentMethod?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserData()
    }
    
    func getUserData(){
        let currentUserID = Auth.auth().currentUser?.uid
        self.ref.child("cardDetails").child(currentUserID!).child("\(self.onePaymentType?.paymentName ?? "card")").observe(.value, with: {(snapshot) in
                self.cardListData.removeAll()
                for snap in snapshot.children.allObjects as! [DataSnapshot]{
                    let mainDict = snap.value as? [String: AnyObject]
                    let cardNumber = mainDict?["cardNumber"]
                    let cardHolder = mainDict?["cardHolder"]
                    let expiryDate = mainDict?["expiryDate"]
                    let cvv = mainDict?["cvv"]
                    
                    let users = cardDetails(cardNumber: cardNumber as! String, cardHolder: cardHolder as! String, expiryDate: expiryDate as! String, cvv: cvv as! String)
                    print(users.cardNumber)
                    self.cardListData.append(users)
                }
                self.cardListTableView.reloadData()
            })
        }
    
}


extension userCardsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cardListTableView.dequeueReusableCell(withIdentifier: "userCardsTableViewCell", for: indexPath) as! userCardsTableViewCell
        let myCard : cardDetails
        myCard = cardListData[indexPath.row]
        cell.cardHolder.text = myCard.cardHolder
        cell.cardNumberLabel.text = myCard.cardNumber
        return cell
    }
    
    
}
