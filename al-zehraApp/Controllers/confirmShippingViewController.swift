//
//  confirmShippingViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-25.
//

import UIKit
import Firebase

class confirmShippingViewController: UIViewController {

    enum Identifiers: String {
            case CellIdentifier = "Cell"
        }
    
    @IBOutlet var addressTableView: UITableView!
    @IBOutlet var orderConfirmCollectionView: UICollectionView!
    @IBOutlet var storeAddressView: UIView!
    @IBOutlet var libraryAddressView: UIView!
    @IBOutlet var homeAddressView: UIView!
    @IBOutlet var continueShippingBtn: UIView!
    @IBOutlet var totalAmount: UILabel!
    
    var amountTotal: String?

    
    let userKey = Auth.auth().currentUser?.uid
    
    var getAddress = [userDetails]()
    
    var dummyData = [Any]()
    
    var NotificationBool = "No"
    
    var orderConfirmImage2 = [cart]()
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getDataFromDB()
        self.totalAmount.text = "\(amountTotal ?? "")"
        
        debugPrint("NotificationBool : \(NotificationBool)")
        
        orderConfirmCollectionView.contentInsetAdjustmentBehavior = .never
        
        storeAddressView.layer.borderWidth = 2
        storeAddressView.layer.borderColor = UIColor.tertiaryLabel.cgColor
        
        libraryAddressView.layer.borderWidth = 2
        libraryAddressView.layer.borderColor = UIColor.tertiaryLabel.cgColor
        
        homeAddressView.layer.borderWidth = 2
        homeAddressView.layer.borderColor = UIColor.tertiaryLabel.cgColor
        
        continueShippingBtn.layer.borderWidth = 2
        continueShippingBtn.layer.borderColor = UIColor.tertiaryLabel.cgColor
        
        self.addressTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        orderConfirmCollectionView.register(TitleHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeader.reuseIdentifier)
    }
    
    func getDataFromDB(){
        let currentUserID = Auth.auth().currentUser?.uid
        self.ref.child("userDetails").child(currentUserID!).observe(.value, with: {(snapshot) in
            self.getAddress.removeAll()
            
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let userKey = snap.key
                let mainDict = snap.value as? [String: AnyObject]
                let firstName = mainDict?["firstName"]
                let LastName = mainDict?["LastName"]
                let phone = mainDict?["phone"]
                let password = mainDict?["password"]
                let userUID = mainDict?["userUID"]
                let email = mainDict?["email"]
                let addressLine1 = mainDict?["addressLine1"]
                let addressLine2 = mainDict?["addressLine2"]
                let postalCode = mainDict?["postalCode"]
                let city = mainDict?["city"]
                
                let users = userDetails(firstName: firstName as! String, LastName: LastName as! String, phone: phone as! String, email: email as! String, password: password as! String, userUID: userUID as! String, addressLine1: addressLine1 as! String, addressLine2: addressLine2 as! String, postalCode: postalCode as! String, city: city as! String)
                if userKey == "primaryDetails" {
                    self.getAddress.append(users)
                }else{
                    print("nokkkkkkkkk")
                }
             }
            
            self.addressTableView.reloadData()
        })
    }
    
    @IBAction func continueToPaymentPage(_ sender: UIButton) {
        let VC01 = storyboard?.instantiateViewController(withIdentifier: "selectPaymentViewController") as? selectPaymentViewController
        VC01?.itemData = self.orderConfirmImage2
        VC01?.totalFinalAmount = self.amountTotal!
        
        VC01?.NotificationBool = self.NotificationBool
        
        navigationController?.pushViewController(VC01!, animated: true)
    }
    
}
extension confirmShippingViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addressTableView.dequeueReusableCell(withIdentifier: "addressShipping", for: indexPath) as! addressShipping
        
        self.addressTableView.separatorStyle = .none
        cell.selectionStyle = .none
        cell.textLabel?.text = getAddress[indexPath.row].addressLine1 + ", " + getAddress[indexPath.row].addressLine2 + " " + getAddress[indexPath.row].city
        cell.accessoryType = .disclosureIndicator
        return cell
    }

}
extension confirmShippingViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        debugPrint("orderConfirmImage count = \(orderConfirmImage2.count)")
        return orderConfirmImage2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = orderConfirmCollectionView.dequeueReusableCell(withReuseIdentifier: "orderConfirm", for: indexPath) as! orderConfirm
        let myCategory: cart
        myCategory = orderConfirmImage2[indexPath.row]
        
        if let url = URL(string: myCategory.imageURL ?? ""){
            cell.orderImage.loadImage14(from: url)
        }
        return cell
    }
}
extension UIImageView{
    func loadImage14(from url: URL){
        
        let newSpinner = UIActivityIndicatorView(style: .medium)
        newSpinner.hidesWhenStopped = true
        newSpinner.center = center
        newSpinner.startAnimating()
        self.addSubview(newSpinner)
        
        var task: URLSessionDataTask!
        let imageCache = NSCache<AnyObject, AnyObject>()
        
        image = nil
        
        if let task = task {
            task.cancel()
        }
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        task = URLSession.shared.dataTask(with: url){(data, response, error) in
            guard
                let data = data,
                let newImage = UIImage(data: data)
            else{
                print("error")
                return
            }
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = newImage
                newSpinner.stopAnimating()
            }
        }
        task.resume()
    }
}

extension Notification.Name{
    static let getNotificationFromCart = Notification.Name("getNotificationFromCart")
}
