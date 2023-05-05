//
//  BookDetailsViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-31.
//

import UIKit
import Firebase

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
        self.addCartLoading.startAnimating()
        let dict = ["bookName" : bookNameLabel.text!, "authorName" : authorNameLabel.text!, "bookPrice" : bookPriceLabel.text!]
        self.ref.child("itemList").childByAutoId().setValue(dict)
        self.addCartLoading.stopAnimating()
        self.showToast(message: "Added to cart", font: .systemFont(ofSize: 12.0))
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

