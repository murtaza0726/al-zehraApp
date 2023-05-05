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
    let bookPhoto: [String]
    let price: [String]
    let author: [String]
    var bookDetailsObj: [bookDetailsData]
    
    init(bName: String, LogoName: String, NameList:[String], bPhoto:[String], bookPrice:[String], bookAuthor:[String], bData:[bookDetailsData ]) {
        bookName = bName
        bookLogoName = LogoName
        bookNameList = NameList
        bookPhoto = bPhoto
        price = bookPrice
        author = bookAuthor
        bookDetailsObj = bData
    }
}
