//
//  BookDetailsViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-31.
//

import UIKit
import Firebase
import FirebaseStorage

class BookDetailsViewController: UIViewController {
    
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var bookPriceLabel: UILabel!
    @IBOutlet var bookImageUI: UIImageView!
    @IBOutlet var bookNameLabel: UILabel!
    @IBOutlet var descrip: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var productStock: UILabel!
    @IBOutlet var productRating: UIImageView!
    @IBOutlet var bookRatingNumber: UILabel!
    
    
    var url_ratingZero = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-0.png?alt=media&token=684078e0-e930-4fc8-a53b-56f804cf07f2"
    var url_ratingOne = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-1.png?alt=media&token=b370a027-91c0-433d-a9b1-9269e000b8df"
    var url_ratingTwo = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-2.png?alt=media&token=d5c77cf2-3a03-4547-929f-28649f623755"
    var url_ratingThree = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-3.png?alt=media&token=a853915e-13e6-4c36-9e2c-e381cad6d44e"
    var url_ratingFour = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-4.png?alt=media&token=15af6f97-28c7-48b3-9cca-60f99cebf890"
    var url_ratingFive = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-5.png?alt=media&token=121f8391-ee19-40bf-8db2-1c973deb3dcf"
    
    var oneBookDetail: bookList?
    
    
    @IBOutlet var addCartSpinner: UIActivityIndicatorView!
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addCartSpinner.hidesWhenStopped = true
        self.ref = Database.database().reference()
        
        self.title = "Book Details "
        bookNameLabel.text = oneBookDetail?.title
        authorNameLabel.text = "by " + oneBookDetail!.author
        bookPriceLabel.text = oneBookDetail!.price
        descriptionLabel.text = oneBookDetail?.description
        productStock.text = oneBookDetail?.productStock
        //print(oneBookDetail?.productRating)
        
        if oneBookDetail?.productRating == "0"{
            if let urlZero = URL(string: url_ratingZero){
                productRating.loadImage1(from: urlZero)
                self.bookRatingNumber.text = "N/A"
            }
        }
        if oneBookDetail?.productRating == "1"{
            if let urlOne = URL(string: url_ratingOne){
                productRating.loadImage1(from: urlOne)
                self.bookRatingNumber.text = "1.0"
            }
        }
        if oneBookDetail?.productRating == "2"{
            if let urlTwo = URL(string: url_ratingTwo){
                productRating.loadImage1(from: urlTwo)
                self.bookRatingNumber.text = "2.0"
            }
        }
        if oneBookDetail?.productRating == "3"{
            if let urlThree = URL(string: url_ratingThree){
                productRating.loadImage1(from: urlThree)
                self.bookRatingNumber.text = "3.0"
            }
        }
        if oneBookDetail?.productRating == "4"{
            if let urlFour = URL(string: url_ratingFour){
                productRating.loadImage1(from: urlFour)
                self.bookRatingNumber.text = "4.0"
            }
        }
        if oneBookDetail?.productRating == "5"{
            if let urlFive = URL(string: url_ratingFive){
                productRating.loadImage1(from: urlFive)
                self.bookRatingNumber.text = "5.0"
            }
        }

        if oneBookDetail?.productStock == "0" {
            productStock?.text = "Out of Stock"
            productStock.textColor = .red
        }else{
            productStock?.text = "In Stock"
            productStock.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 2.0)
        }
        bookImageUI.image = UIImage(named: oneBookDetail!.imageURL)
        if let url = URL(string: oneBookDetail!.imageURL){
            bookImageUI.loadImage1(from: url)
        }
    }
    
    func ActivitySpinner(){
        addCartSpinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addCartSpinner)
        addCartSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addCartSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @IBAction func addToCartBtn(_ sender: UIButton) {
        self.SaveDataDB()
    }
    
    func SaveDataDB(){
        self.addCartSpinner.hidesWhenStopped = false
        self.addCartSpinner.startAnimating()
        self.uploadImage(self.bookImageUI.image!){url in
            self.saveImageData(bookName: self.bookNameLabel.text!, description: self.descriptionLabel.text!, authorName: self.authorNameLabel.text!, bookRating: self.bookRatingNumber.text!, bookPrice: self.bookPriceLabel.text!, productStock: self.productStock.text!, imageURL: url!){
                success in
                if(success != nil){
                    print("yeah")

                }
            }
        }
    }
}
extension BookDetailsViewController {
    
    func showToast(message : String, font: UIFont) {
        
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


extension BookDetailsViewController{
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
        let dict = ["id": key as Any, "bookName" : bookNameLabel.text!,"description": descriptionLabel.text!, "authorName" : authorNameLabel.text!, "bookPrice" : bookPriceLabel.text!, "bookRating": self.bookRatingNumber.text! ,"productStock": self.productStock.text!, "imageURL": imageURL.absoluteString] as [String: Any]
        if userKey != nil{
            self.ref.child("itemList/\(userKey!)").child(key!).setValue(dict)
            self.addCartSpinner.stopAnimating()
            self.addCartSpinner.hidesWhenStopped = true
            self.showToast(message: "Added to cart", font: .systemFont(ofSize: 12.0))
        }else{
            self.ref.child("itemList/defaultUser").child(key!).setValue(dict)
            self.addCartSpinner.stopAnimating()
            self.addCartSpinner.hidesWhenStopped = true
            self.showToast(message: "Added to cart", font: .systemFont(ofSize: 12.0))
        }
    }
}

extension UIImageView{
    func loadImage2(from url: URL){
        
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

