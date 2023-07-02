//
//  bookList.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-05-12.
//

import Foundation
import UIKit

class bookList{
    let bookName: String
    let authorName: String
    let description: String
    let bookPrice: String
    let imageURL: String
    let productStock: String
    let productRating: String
    
    init(bookName: String, authorName: String, description: String, bookPrice: String, imageURL: String, productStock: String, productRating: String) {
        self.bookName = bookName
        self.authorName = authorName
        self.description = description
        self.bookPrice = bookPrice
        self.imageURL = imageURL
        self.productStock = productStock
        self.productRating = productRating
    }
}
