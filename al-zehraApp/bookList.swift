//
//  bookList.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-05-12.
//

import Foundation
import UIKit

class bookList{
    let title: String
    let author: String
    let description: String
    let price: String
    let imageURL: String
    
    init(title: String, author: String, description: String, price: String, imageURL: String) {
        self.title = title
        self.author = author
        self.description = description
        self.price = price
        self.imageURL = imageURL
    }
}
