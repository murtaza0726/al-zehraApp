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
    var bookImage: String?
    var bookPrice: String?
    
    init(bookName: String, authorName: String, bookImage: String, bookPrice: String) {
        self.bookName = bookName
        self.authorName = authorName
        self.bookImage = bookImage
        self.bookPrice = bookPrice
    }
}
