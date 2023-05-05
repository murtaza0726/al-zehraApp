//
//  bookDetailsData.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-31.
//

import Foundation

class bookDetailsData{
    
    let bookDetailsImage: String
    let bookDetailsName: String
    let bookDetailsAuthor:String
    let bookDetailsPrice:String
    
    init(bookDetailsImage: String, bookDetailsName: String, bookDetailsAuthor: String, bookDetailsPrice: String) {
        self.bookDetailsImage = bookDetailsImage
        self.bookDetailsName = bookDetailsName
        self.bookDetailsAuthor = bookDetailsAuthor
        self.bookDetailsPrice = bookDetailsPrice
    }
}
