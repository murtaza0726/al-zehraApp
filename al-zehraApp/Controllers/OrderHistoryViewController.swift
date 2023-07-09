//
//  OrderHistoryViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-07-03.
//

import UIKit
import Firebase

class OrderHistoryViewController: UIViewController {

    
    @IBOutlet var orderHistoryTableView: UITableView!
    
    var orderHistory = [cart]()
    
    
    let userKey = Auth.auth().currentUser?.uid
    var ref = Database.database().reference()
    
    var data: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.getUserData()
        self.getDbData()
//        let today = Date()
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMMM dd yyyy"
//
//        var presentData = dateFormatter.string(from: today)
//
//        print("presentDate :::::: \(presentData)")
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let headerLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width, height: 40))
        headerLabel.text = "Order History"
        
        header.addSubview(headerLabel)
        headerLabel.adjustsFontSizeToFitWidth = true
        headerLabel.font = .boldSystemFont(ofSize: 25)
        orderHistoryTableView.tableHeaderView = header
        
    }
    func getUserData(){
        self.ref.child("Order History/\(userKey!)/").observeSingleEvent(of : .value, with: {(snapshot) in
            self.orderHistory.removeAll()
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
                self.orderHistory.append(cartM)
            }
            self.orderHistoryTableView.reloadData()
            })
        }
    func getDbData(){
        self.ref.child("Order History/\(userKey!)/").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                if let value = snapshot.value as? [String: Any] {
                    self.data = value
                    self.orderHistoryTableView.reloadData()
                    debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> value: \(value) <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
                }
            }  else {
                print("Node does not exist")
            }
        }
    }
}
extension OrderHistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        //return orderHistory.count
        return data.keys.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderHistoryTableView.dequeueReusableCell(withIdentifier: "OrderHistoryTableViewCell", for: indexPath) as! OrderHistoryTableViewCell
        
        let key = Array(data.keys)[indexPath.section]
        let value = data[key]
        
        cell.bookName.text = key
        
//        cell.bookName.text = orderHistory[indexPath.section].bookName
//        if let url = URL(string: orderHistory[indexPath.section].imageURL!){
//            cell.imageURL.loadImage20(from: url)
//        }
        return cell
    }
    
    
}
extension UIImageView{
    func loadImage20(from url: URL){
        
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
