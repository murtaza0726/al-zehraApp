//
//  authorBookList.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-24.
//


import Foundation
import UIKit

class authorBookList{
    
    var authorName: String
    var imageURL: String?
    var bookName: String
    
    init(authorName: String, imageURL: String, bookName: String) {
        self.authorName = authorName
        self.imageURL = imageURL
        self.bookName = bookName
    }
}

