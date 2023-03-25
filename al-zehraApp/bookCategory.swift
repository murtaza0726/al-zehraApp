//
//  bookCategory.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-22.
//

import Foundation

class bookCategoryData
{
    let bookName:String
    let bookLogoName:String
    let bookNameList:[String]
    let bookPhoto: String
    init(bookName: String, bookLogoName: String, bookNameList:[String], bookPhoto:String) {
        self.bookName = bookName
        self.bookLogoName = bookLogoName
        self.bookNameList = bookNameList
        self.bookPhoto = bookPhoto
    }
}
