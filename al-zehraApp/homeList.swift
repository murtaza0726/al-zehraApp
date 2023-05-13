//
//  homeList.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-05-12.
//

import Foundation
import UIKit

class homeList{
    
    var bookCategory: String
    var bookCoverImage: String?
    
    init(bookCategory: String, bookCoverImage: String) {
        self.bookCategory = bookCategory
        self.bookCoverImage = bookCoverImage
    }
}
