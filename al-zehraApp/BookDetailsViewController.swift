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
            self.saveImageData(bookName: self.bookNameLabel.text!, description: self.descriptionLabel.text!, authorName: self.authorNameLabel.text!, bookPrice: self.bookPriceLabel.text!, imageURL: url!){
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
    func saveImageData(bookName: String,description: String, authorName: String, bookPrice: String, imageURL: URL, completion: @escaping((_ url: URL?) -> ())){
        let key = ref.childByAutoId().key
        let dict = ["id": key as Any, "bookName" : bookNameLabel.text!,"description": descriptionLabel.text!, "authorName" : authorNameLabel.text!, "bookPrice" : bookPriceLabel.text!, "imageURL": imageURL.absoluteString] as [String: Any]
        self.ref.child("itemList").child(key!).setValue(dict)
        self.addCartSpinner.stopAnimating()
        self.addCartSpinner.hidesWhenStopped = true
        self.showToast(message: "Added to cart", font: .systemFont(ofSize: 12.0))
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

