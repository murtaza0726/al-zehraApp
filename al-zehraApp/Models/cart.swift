//
//  cart.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-04-29.
//

import Foundation
import UIKit

class cart{
    var bookName: String?
    var authorName: String?
    var bookPrice: String?
    var imageURL: String?
    var description: String?
    var id: String?
    var productStock: String?
    var bookRating: String?
    
    init(bookName: String,id: String, authorName: String, bookPrice: String, imageURL: String, description: String, productStock: String, bookRating: String) {
        self.bookName = bookName
        self.authorName = authorName
        self.bookPrice = bookPrice
        self.imageURL = imageURL
        self.description = description
        self.id = id
        self.productStock = productStock
        self.bookRating = bookRating
    }
}
