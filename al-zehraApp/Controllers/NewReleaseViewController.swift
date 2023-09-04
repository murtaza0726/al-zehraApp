//
//  NewReleaseViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-20.
//

import UIKit
import Firebase

class NewReleaseViewController: UIViewController {

    @IBOutlet var productRating: UIImageView!
    @IBOutlet var productRatingNumber: UILabel!
    @IBOutlet var bookTitle: UILabel!
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var bookImageUI: UIImageView!
    @IBOutlet var descrip: UILabel!
    @IBOutlet var bookPrice: UILabel!
    @IBOutlet var productStock: UILabel!
    
    
    
    @IBOutlet var favBtn: UIButton!
    
    @IBOutlet var addCartBtn: UIButton!
    @IBOutlet var addFavBtn: UIButton!
    
    @IBOutlet var addToCartSpinner: UIActivityIndicatorView!
    
    var url_ratingZero = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-0.png?alt=media&token=684078e0-e930-4fc8-a53b-56f804cf07f2"
    var url_ratingOne = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-1.png?alt=media&token=b370a027-91c0-433d-a9b1-9269e000b8df"
    var url_ratingTwo = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-2.png?alt=media&token=d5c77cf2-3a03-4547-929f-28649f623755"
    var url_ratingThree = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-3.png?alt=media&token=a853915e-13e6-4c36-9e2c-e381cad6d44e"
    var url_ratingFour = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-4.png?alt=media&token=15af6f97-28c7-48b3-9cca-60f99cebf890"
    var url_ratingFive = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-5.png?alt=media&token=121f8391-ee19-40bf-8db2-1c973deb3dcf"
    
    var oneBookDetail2: String?
    var oneBookDetail4: String?
    var oneBookDetail5: String?
    
    var ref = Database.database().reference()
    let userKey = Auth.auth().currentUser?.uid
    
    var userData = [cart]()
    var bookDetailsImagesToBuy = [cart]()
    
    var identifyBtnClicked = ""
    
    var buyData = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addCartBtn.tag = 101
        self.favBtn.tag = 102
        
        //self.title = oneBookDetail2
        self.addToCartSpinner.hidesWhenStopped = true
        self.getBookData()
    }
    @IBAction func addToCartBtn(_ sender: UIButton) {
        self.SaveDataDB()
        self.identifyBtnClicked.removeAll()
        self.identifyBtnClicked.append("itemList")
        debugPrint("identifyBtnClicked ================== \(identifyBtnClicked)")
    }
    
    @IBAction func buyNow(_ sender: UIButton) {
        debugPrint("buyNow pressed")
        let VC03 = storyboard?.instantiateViewController(withIdentifier: "confirmShippingViewController") as? confirmShippingViewController
        VC03?.orderConfirmImage2 = self.bookDetailsImagesToBuy
        VC03?.amountTotal = ("$ \(self.bookPrice.text!)")
        VC03?.dummyData = self.buyData
        navigationController?.pushViewController(VC03!, animated: true)
    }
    
    
    @IBAction func favoriteBtn(_ sender: UIButton) {
        self.identifyBtnClicked.removeAll()
        self.identifyBtnClicked.append("Fav")
        debugPrint("identifyBtnClicked ================== \(identifyBtnClicked)")
        self.SaveDataDB()

//        favBtn.setImage(UIImage(named: "play.png"), forState: UIControlState.Normal)
    }
    

    
    func SaveDataDB(){
        self.addToCartSpinner.hidesWhenStopped = false
        self.addToCartSpinner.startAnimating()
        self.uploadImage(self.bookImageUI.image!){url in
            self.saveImageData(bookName: self.bookTitle.text!, description: self.descrip.text!, authorName: self.authorNameLabel.text!, bookRating: self.productRatingNumber.text!, bookPrice: self.bookPrice.text!, productStock: self.productStock.text!, imageURL: url!){
                success in
                if(success != nil){
                    print("yeah")

                }
            }
        }
    }
    
    func ActivitySpinner(){
        addToCartSpinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addToCartSpinner)
        addToCartSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addToCartSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func getBookData(){
        if oneBookDetail4 == "Author"{
            
            let databaseRef = Database.database().reference().child("AuthorBookList/Author_Name/\(oneBookDetail5!)")
            
            let query = databaseRef.queryOrdered(byChild: "bookName").queryStarting(atValue: oneBookDetail2!).queryEnding(atValue: "\(oneBookDetail2!))\\uf8ff")
            query.observeSingleEvent(of: .value){(snapshot) in
                guard snapshot.exists() != false else
                {
                    print("Author data not found")
                    return
                }
                DispatchQueue.main.async {
                    for snap in snapshot.children.allObjects as! [DataSnapshot]{
                        guard let dict = snap.value as? [String: AnyObject] else {
                            return
                        }
                        self.buyData.removeAll()
                        let bookName = dict["bookName"]
                        let authorName = dict["authorName"]
                        let bookPrice = dict["bookPrice"]
                        let imageURL = dict["imageURL"]
                        let description = dict["description"]
                        let id = dict["id"]
                        let productStock = dict["productStock"]
                        let bookRating = dict["bookRating"]
                        
                        let Category = cart(bookName: bookName as! String, id: "", authorName: authorName as! String, bookPrice: bookPrice as! String, imageURL: imageURL as! String, description: description as! String, productStock: productStock as! String, bookRating: bookRating as! String)
                        
                        //self.userData.append(Category)
                        self.buyData.append(dict as Any)
                        self.bookTitle.text = Category.bookName
                        self.authorNameLabel.text = Category.authorName
                        self.descrip.text = Category.description
                        self.bookPrice.text = Category.bookPrice
                        self.productRatingNumber.text = Category.bookRating
                        self.productStock.text = Category.productStock
                        
                        self.bookDetailsImagesToBuy.append(Category)
                        
                        if Category.bookRating == "0"{
                            if let urlZero = URL(string: self.url_ratingZero){
                                self.productRating.loadImage12(from: urlZero)
                                self.productRatingNumber.text = "N/A"
                            }
                        }
                        if Category.bookRating == "1"{
                            if let urlOne = URL(string: self.url_ratingOne){
                                self.productRating.loadImage12(from: urlOne)
                                self.productRatingNumber.text = "1.0"
                            }
                        }
                        if Category.bookRating == "2"{
                            if let urlTwo = URL(string: self.url_ratingTwo){
                                self.productRating.loadImage12(from: urlTwo)
                                self.productRatingNumber.text = "2.0"
                            }
                        }
                        if Category.bookRating == "3"{
                            if let urlThree = URL(string: self.url_ratingThree){
                                self.productRating.loadImage12(from: urlThree)
                                self.productRatingNumber.text = "3.0"
                            }
                        }
                        if Category.bookRating == "4"{
                            if let urlFour = URL(string: self.url_ratingFour){
                                self.productRating.loadImage12(from: urlFour)
                                self.productRatingNumber.text = "4.0"
                            }
                        }
                        if Category.bookRating == "5"{
                            if let urlFive = URL(string: self.url_ratingFive){
                                self.productRating.loadImage12(from: urlFive)
                                self.productRatingNumber.text = "5.0"
                            }
                        }

                        if Category.productStock == "0" {
                            self.productStock?.text = "Out of Stock"
                            self.productStock.textColor = .red
                        }else{
                            self.productStock?.text = "In Stock"
                            self.productStock.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 2.0)
                        }
                        self.bookImageUI.image = UIImage(named: Category.imageURL ?? "")
                        if let url = URL(string: Category.imageURL ?? ""){
                            self.bookImageUI.loadImage12(from: url)
                        }
                    }
                    
                }
            }
        }
        else if (oneBookDetail4 == "Category"){
            let databaseRef = Database.database().reference().child("BookList/\(oneBookDetail5!)")
            
            let query = databaseRef.queryOrdered(byChild: "bookName").queryStarting(atValue: oneBookDetail2!).queryEnding(atValue: "\(oneBookDetail2!))\\uf8ff")
            query.observeSingleEvent(of: .value){(snapshot) in
                guard snapshot.exists() != false else
                {
                    print("Category data not found")
                    return
                }
                DispatchQueue.main.async {
                    
                    for snap in snapshot.children.allObjects as! [DataSnapshot]{
                        guard let dict = snap.value as? [String: AnyObject] else {
                            return
                        }
                        self.buyData.removeAll()
                        
                        let bookName = dict["bookName"]
                        let authorName = dict["authorName"]
                        let bookPrice = dict["bookPrice"]
                        let imageURL = dict["imageURL"]
                        let description = dict["description"]
                        let id = dict["id"]
                        let productStock = dict["productStock"]
                        let bookRating = dict["bookRating"]
                        
                        let Category = cart(bookName: bookName as! String, id: "", authorName: authorName as! String, bookPrice: bookPrice as! String, imageURL: imageURL as! String, description: description as! String, productStock: productStock as! String, bookRating: bookRating as! String)
                        
                        //self.userData.append(Category)
                        
                        self.buyData.append(dict as Any)
                        
                        
                        self.bookTitle.text = Category.bookName
                        self.authorNameLabel.text = Category.authorName
                        self.descrip.text = Category.description
                        self.bookPrice.text = Category.bookPrice
                        self.productRatingNumber.text = Category.bookRating
                        self.productStock.text = Category.productStock
                        
                        self.bookDetailsImagesToBuy.append(Category)
                        
                        if Category.bookRating == "0"{
                            if let urlZero = URL(string: self.url_ratingZero){
                                self.productRating.loadImage12(from: urlZero)
                                self.productRatingNumber.text = "N/A"
                            }
                        }
                        if Category.bookRating == "1"{
                            if let urlOne = URL(string: self.url_ratingOne){
                                self.productRating.loadImage12(from: urlOne)
                                self.productRatingNumber.text = "1.0"
                            }
                        }
                        if Category.bookRating == "2"{
                            if let urlTwo = URL(string: self.url_ratingTwo){
                                self.productRating.loadImage12(from: urlTwo)
                                self.productRatingNumber.text = "2.0"
                            }
                        }
                        if Category.bookRating == "3"{
                            if let urlThree = URL(string: self.url_ratingThree){
                                self.productRating.loadImage12(from: urlThree)
                                self.productRatingNumber.text = "3.0"
                            }
                        }
                        if Category.bookRating == "4"{
                            if let urlFour = URL(string: self.url_ratingFour){
                                self.productRating.loadImage12(from: urlFour)
                                self.productRatingNumber.text = "4.0"
                            }
                        }
                        if Category.bookRating == "5"{
                            if let urlFive = URL(string: self.url_ratingFive){
                                self.productRating.loadImage12(from: urlFive)
                                self.productRatingNumber.text = "5.0"
                            }
                        }

                        if Category.productStock == "0" {
                            self.productStock?.text = "Out of Stock"
                            self.productStock.textColor = .red
                        }else{
                            self.productStock?.text = "In Stock"
                            self.productStock.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 2.0)
                        }
                        self.bookImageUI.image = UIImage(named: Category.imageURL ?? "")
                        if let url = URL(string: Category.imageURL ?? ""){
                            self.bookImageUI.loadImage12(from: url)
                        }
                    }
                }
            }
        }
        let databaseRef = Database.database().reference().child("\(oneBookDetail4!)")
        let query = databaseRef.queryOrdered(byChild: "bookName").queryStarting(atValue: oneBookDetail2!).queryEnding(atValue: "\(oneBookDetail2!))\\uf8ff")
        query.observeSingleEvent(of: .value){(snapshot) in
            guard snapshot.exists() != false else
            {
                print("data not found")
                return
            }
            DispatchQueue.main.async {
                
                for snap in snapshot.children.allObjects as! [DataSnapshot]{
                    guard let dict = snap.value as? [String: AnyObject] else {
                        return
                    }
                    
                    self.buyData.removeAll()
                    
                    let bookName = dict["bookName"]
                    let authorName = dict["authorName"]
                    let bookPrice = dict["bookPrice"]
                    let imageURL = dict["imageURL"]
                    let description = dict["description"]
                    let id = dict["id"]
                    let productStock = dict["productStock"]
                    let bookRating = dict["bookRating"]
                    
                    let Category = cart(bookName: bookName as! String, id: "", authorName: authorName as! String, bookPrice: bookPrice as! String, imageURL: imageURL as! String, description: description as! String, productStock: productStock as! String, bookRating: bookRating as! String)
                    
                    //self.userData.append(Category)
                    
                    self.bookTitle.text = Category.bookName
                    self.authorNameLabel.text = Category.authorName
                    self.descrip.text = Category.description
                    self.bookPrice.text = Category.bookPrice
                    self.productRatingNumber.text = Category.bookRating
                    self.productStock.text = Category.productStock
                    
                    self.bookDetailsImagesToBuy.append(Category)
                    self.buyData.append(dict as Any)
                    
                    if Category.bookRating == "0"{
                        if let urlZero = URL(string: self.url_ratingZero){
                            self.productRating.loadImage12(from: urlZero)
                            self.productRatingNumber.text = "N/A"
                        }
                    }
                    if Category.bookRating == "1"{
                        if let urlOne = URL(string: self.url_ratingOne){
                            self.productRating.loadImage12(from: urlOne)
                            self.productRatingNumber.text = "1.0"
                        }
                    }
                    if Category.bookRating == "2"{
                        if let urlTwo = URL(string: self.url_ratingTwo){
                            self.productRating.loadImage12(from: urlTwo)
                            self.productRatingNumber.text = "2.0"
                        }
                    }
                    if Category.bookRating == "3"{
                        if let urlThree = URL(string: self.url_ratingThree){
                            self.productRating.loadImage12(from: urlThree)
                            self.productRatingNumber.text = "3.0"
                        }
                    }
                    if Category.bookRating == "4"{
                        if let urlFour = URL(string: self.url_ratingFour){
                            self.productRating.loadImage12(from: urlFour)
                            self.productRatingNumber.text = "4.0"
                        }
                    }
                    if Category.bookRating == "5"{
                        if let urlFive = URL(string: self.url_ratingFive){
                            self.productRating.loadImage12(from: urlFive)
                            self.productRatingNumber.text = "5.0"
                        }
                    }

                    if Category.productStock == "0" {
                        self.productStock?.text = "Out of Stock"
                        self.productStock.textColor = .red
                    }else{
                        self.productStock?.text = "In Stock"
                        self.productStock.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 2.0)
                    }
                    self.bookImageUI.image = UIImage(named: Category.imageURL ?? "")
                    if let url = URL(string: Category.imageURL ?? ""){
                        self.bookImageUI.loadImage12(from: url)
                    }
                }
                
            }
        }
    }
}
extension UIImageView{
    func loadImage12(from url: URL){
        
        let newSpinner2 = UIActivityIndicatorView(style: .large)
        newSpinner2.hidesWhenStopped = true
        newSpinner2.frame = CGRect(x: 0, y: 0, width: 64, height: 150)
        newSpinner2.center = center
        newSpinner2.startAnimating()
        addSubview(newSpinner2)
        
        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            guard
                let data = data,
                let newImage = UIImage(data: data)
            else{
                print("error")
                return
            }
            DispatchQueue.main.async {
                self.image = newImage
                newSpinner2.stopAnimating()
            }
        }
        task.resume()
    }
}
extension NewReleaseViewController {
    
    func showToast1(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-150, width: 150, height:35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 10.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
extension NewReleaseViewController{
    func uploadImage(_ image: UIImage, completion: @escaping((_ url : URL?) -> ())){
        let fileName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("Images/").child(fileName)
        let imgData = bookImageUI.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata:metaData){(metaData, error) in
            if error == nil{
                print("Success")
                storageRef.downloadURL(completion: {(url, error) in
                    completion(url)
                })
            }else{
                print("error in saving image")
                completion(nil)
            }
        }
    }
    func saveImageData(bookName: String,description: String, authorName: String, bookRating: String, bookPrice: String, productStock: String, imageURL: URL, completion: @escaping((_ url: URL?) -> ())){

        let key = ref.childByAutoId().key
        let userKey = Auth.auth().currentUser?.uid
        let dict = ["id": key as Any, "bookName" : self.bookTitle.text!,"description": self.descrip.text!, "authorName" : self.authorNameLabel.text!, "bookPrice" : self.bookPrice.text!, "bookRating": self.productRatingNumber.text! ,"productStock": self.productStock.text!, "imageURL": imageURL.absoluteString] as [String: Any]

            if userKey != nil{
                self.ref.child("\(self.identifyBtnClicked)/\(userKey!)").child(key!).setValue(dict)
                self.addToCartSpinner.stopAnimating()
                self.addToCartSpinner.hidesWhenStopped = true
                self.showToast1(message: "Added to \(self.identifyBtnClicked)", font: .systemFont(ofSize: 12.0))
                self.favBtn.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
            }else{
                self.ref.child("\(self.identifyBtnClicked)/defaultUser").child(key!).setValue(dict)
                self.addToCartSpinner.stopAnimating()
                self.addToCartSpinner.hidesWhenStopped = true
                self.showToast1(message: "Added to \(self.identifyBtnClicked)", font: .systemFont(ofSize: 12.0))
                
            }
    }
}
extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
