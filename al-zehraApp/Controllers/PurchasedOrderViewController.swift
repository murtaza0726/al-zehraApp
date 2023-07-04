//
//  PurchasedOrderViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-30.
//

import UIKit
import Firebase

class PurchasedOrderViewController: UIViewController {

    var orderID = ""
    var getAddress = [userDetails]()
    
    let userKey = Auth.auth().currentUser?.uid
    
    @IBOutlet var bestSellerCollectionView: UICollectionView!
    
    @IBOutlet var orderId: UILabel!
    @IBOutlet var estimatedArrivalDate: UILabel!
    @IBOutlet var userAddress: UILabel!
    @IBOutlet var postalCity: UILabel!
    @IBOutlet var phoneNumber: UILabel!
    @IBOutlet var addressView: UIView!
    
    let ref = Database.database().reference()
    
    var bestSeller2 = [cart]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.scrollDirection = .horizontal
        //layout.itemSize = CGSize(width: width / 2, height: width / 2)
        //layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        bestSellerCollectionView!.collectionViewLayout = layout
        
        bestSellerCollectionView?.register(TitleHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeader.reuseIdentifier)
        
        self.getUserData()
        let randomInt2 = Int.random(in: 1..<7)
        
        //order date
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: randomInt2, to: today)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy"
        let dateString = dateFormatter.string(from: tomorrow!)
        
        self.orderId.text = orderID
        self.estimatedArrivalDate.text =  dateString
        self.getUserPrimaryAddress()
        
        addressView.layer.borderWidth = 1
        addressView.layer.borderColor = UIColor.tertiaryLabel.cgColor
    }
    
    func getUserPrimaryAddress(){
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
                    self.userAddress.text = users.addressLine1 + ", " + users.addressLine2
                    self.postalCity.text = users.postalCode + " " + users.city
                    self.phoneNumber.text = users.phone
                }else{
                    print("nokkkkkkkkk")
                }
             }
            //self.userAddressTableView.reloadData()
        })
    }
    
    func getUserData(){
        
            self.ref.child("Best Seller").observe(.value, with: {(snapshot) in
                self.bestSeller2.removeAll()
                for snap in snapshot.children.allObjects as! [DataSnapshot]{
                    let mainDict = snap.value as? [String: AnyObject]
                    let bookName = mainDict?["bookName"]
                    let authorName = mainDict?["authorName"]
                    let bookPrice = mainDict?["bookPrice"]
                    let imageURL = mainDict?["imageURL"]
                    let description = mainDict?["description"]
                    let id = mainDict?["id"]
                    let productStock = mainDict?["productStock"]
                    let bookRating = mainDict?["bookRating"]
                    let cartM = cart(bookName: bookName as! String? ?? "", id: id as! String? ?? "", authorName: authorName as! String? ?? "", bookPrice: bookPrice as! String? ?? "", imageURL: imageURL as! String? ?? "", description: description as! String? ?? "", productStock: productStock as! String? ?? "", bookRating: bookRating as! String? ?? "")
                    self.bestSeller2.append(cartM)
                }
                self.bestSellerCollectionView.reloadData()
            })
        }
}
extension PurchasedOrderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bestSeller2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = bestSellerCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeader.reuseIdentifier, for: indexPath) as! TitleHeader
        header.textLabel.text = "Header"
        
        return header
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: 100, height: 2)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bestSellerCollectionView.dequeueReusableCell(withReuseIdentifier: "BestsellerCell", for: indexPath) as! BestsellerCell
        cell.label.text = bestSeller2[indexPath.row].bookName
        
        if let url = URL(string: bestSeller2[indexPath.row].imageURL!){
            cell.bestsellerImage.loadImage30(from: url)
        }
        return cell
    }
}
extension UIImageView{
    func loadImage30(from url: URL){
        
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
