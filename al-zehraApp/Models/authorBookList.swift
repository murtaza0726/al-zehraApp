//
//  authorBookList.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-24.
//


import Foundation
import UIKit

class authorBookList{
    
    var author: String
    var imageURL: String?
    var title: String
    
    init(author: String, imageURL: String, title: String) {
        self.author = author
        self.imageURL = imageURL
        self.title = title
    }
}

