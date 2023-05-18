//
//  Favorite.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-05-17.
//

import Foundation
import UIKit

class Favorite{
    var bookName: String?
    var authorName: String?
    var bookPrice: String?
    var imageURL: String?
    var description: String?
    var id: String?
    
    init(bookName: String,id: String, authorName: String, bookPrice: String, imageURL: String, description: String) {
        self.bookName = bookName
        self.authorName = authorName
        self.bookPrice = bookPrice
        self.imageURL = imageURL
        self.description = description
        self.id = id
    }
}
