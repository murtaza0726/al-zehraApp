//
//  BookManager.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-16.
//

import Foundation
import UIKit
import Firebase

struct BookManager{
    enum Section: String, CaseIterable{
        case HIGHLIGHTS = "HighLights"
        case POPULAR = "Popular"
        case AUTHOR = "Author"
        case CATEGORY = "Category"
        case BESTSELLER = "Best Seller"
    }
    
    static var offersAd2 = [OffersModel]()
    
    static var offers = [
        Section.HIGHLIGHTS:
           [

            OffersModel(bookName: "Book1", headerImage: "offer1"),
            OffersModel(bookName: "Book2", headerImage: "offer2"),
            OffersModel(bookName: "Book3", headerImage: "offer3"),
            OffersModel(bookName: "Book4", headerImage: "offer4")
        ],
        Section.POPULAR:
        [
            OffersModel(bookName: "The God of Small Things", headerImage: "The God of Small Things"),
            OffersModel(bookName: "The Immortals of Meluha", headerImage: "The Immortals Of Meluha"),
            OffersModel(bookName: "The Alchemist", headerImage: "the alchemist"),
            OffersModel(bookName: "Five Point Someone", headerImage: "five_point")
        ],
        Section.AUTHOR:
        [
            OffersModel(bookName: "Arundhati Roy", headerImage: "author-5"),
            OffersModel(bookName: "Vikram Seth", headerImage: "author-6"),
            OffersModel(bookName: "V E Schwab", headerImage: "author-7"),
            OffersModel(bookName: "Jhumpa Lahiri", headerImage: "author-8")
        ],
        Section.CATEGORY:
        [
            OffersModel(bookName: "Adventure", headerImage: "cover-1"),
            OffersModel(bookName: "Classics", headerImage: "cover-2"),
            OffersModel(bookName: "Crime", headerImage: "cover-3"),
            OffersModel(bookName: "Family", headerImage: "cover-4"),
            OffersModel(bookName: "Fantasy", headerImage: "cover-5"),
            OffersModel(bookName: "Fiction", headerImage: "cover-6"),
            OffersModel(bookName: "Horror", headerImage: "cover-7"),
            OffersModel(bookName: "Humour_Satire", headerImage: "cover-8"),
            OffersModel(bookName: "Non-Fiction", headerImage: "cover-9"),
            OffersModel(bookName: "Romance", headerImage: "cover-10")
        ],
        Section.BESTSELLER:
        [
            OffersModel(bookName: "IKIGAI", headerImage: "Ikigai"),
            OffersModel(bookName: "Where the Forest Meets the Stars", headerImage: "Where the Forest Meets the Stars"),
            OffersModel(bookName: "The Art of War", headerImage: "The Art of War"),
            OffersModel(bookName: "The Pilgrimage", headerImage: "The Pilgrimage"),
            OffersModel(bookName: "The Silk Roads - A New History of the World", headerImage: "The Silk Roads - A New History of the World"),
            OffersModel(bookName: "The Song of Achilles", headerImage: "The Song of Achilles")
        ]
    ]
}
