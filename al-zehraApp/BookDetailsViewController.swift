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
    
    var oneBookDetail: bookDetailsData?
    @IBOutlet var addCartLoading: UIActivityIndicatorView!
    
    var ref = DatabaseReference.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        
        self.title = "Book Details "
        bookNameLabel.text = oneBookDetail?.bookDetailsName
        bookImageUI.image = UIImage(named: oneBookDetail!.bookDetailsImage)
        bookNameLabel.text = oneBookDetail?.bookDetailsName
        bookPriceLabel.text = "$ " + oneBookDetail!.bookDetailsPrice
        authorNameLabel.text = "by " + oneBookDetail!.bookDetailsAuthor + " (author)"
    }
    
    @IBAction func addToCartBtn(_ sender: UIButton) {
        self.SaveDataDB()
    }
    
    func SaveDataDB(){
        
        self.uploadImage(self.bookImageUI.image!){url in
            self.saveImageData(bookName: self.bookNameLabel.text!, authorName: self.authorNameLabel.text!, bookPrice: self.bookPriceLabel.text!, imageURL: url!){
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
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

extension BookDetailsViewController{
    func uploadImage(_ image: UIImage, completion: @escaping((_ url : URL?) -> ())){
        let storageRef = Storage.storage().reference().child("myImage.png")
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
    func saveImageData(bookName: String, authorName: String, bookPrice: String, imageURL: URL, completion: @escaping((_ url: URL?) -> ())){
        self.addCartLoading.startAnimating()
        let dict = ["bookName" : bookNameLabel.text!, "authorName" : authorNameLabel.text!, "bookPrice" : bookPriceLabel.text!, "imageURL": imageURL.absoluteString] as [String: Any]
        self.ref.child("itemList").childByAutoId().setValue(dict)
        self.addCartLoading.stopAnimating()
        self.showToast(message: "Added to cart", font: .systemFont(ofSize: 12.0))
    }
}

