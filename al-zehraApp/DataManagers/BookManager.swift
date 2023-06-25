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

            OffersModel(title: "Book1", headerImage: "offer1"),
            OffersModel(title: "Book2", headerImage: "offer2"),
            OffersModel(title: "Book3", headerImage: "offer3"),
            OffersModel(title: "Book4", headerImage: "offer4")
        ],
        Section.POPULAR:
        [
            OffersModel(title: "The God of Small Things", headerImage: "The God of Small Things"),
            OffersModel(title: "The Immortals of Meluha", headerImage: "The Immortals Of Meluha"),
            OffersModel(title: "The Alchemist", headerImage: "the alchemist"),
            OffersModel(title: "Five Point Someone", headerImage: "five_point")
        ],
        Section.AUTHOR:
        [
            OffersModel(title: "Arundhati Roy", headerImage: "author-5"),
            OffersModel(title: "Vikram Seth", headerImage: "author-6"),
            OffersModel(title: "V E Schwab", headerImage: "author-7"),
            OffersModel(title: "Jhumpa Lahiri", headerImage: "author-8")
        ],
        Section.CATEGORY:
        [
            OffersModel(title: "Adventure", headerImage: "cover-1"),
            OffersModel(title: "Classics", headerImage: "cover-2"),
            OffersModel(title: "Crime", headerImage: "cover-3"),
            OffersModel(title: "Family", headerImage: "cover-4"),
            OffersModel(title: "Fantasy", headerImage: "cover-5"),
            OffersModel(title: "Fiction", headerImage: "cover-6"),
            OffersModel(title: "Horror", headerImage: "cover-7"),
            OffersModel(title: "Humour_Satire", headerImage: "cover-8"),
            OffersModel(title: "Non-Fiction", headerImage: "cover-9"),
            OffersModel(title: "Romance", headerImage: "cover-10")
        ],
        Section.BESTSELLER:
        [
            OffersModel(title: "IKIGAI", headerImage: "Ikigai"),
            OffersModel(title: "Where the Forest Meets the Stars", headerImage: "Where the Forest Meets the Stars"),
            OffersModel(title: "The Art of War", headerImage: "The Art of War"),
            OffersModel(title: "The Pilgrimage", headerImage: "The Pilgrimage"),
            OffersModel(title: "The Silk Roads - A New History of the World", headerImage: "The Silk Roads - A New History of the World"),
            OffersModel(title: "The Song of Achilles", headerImage: "The Song of Achilles")
        ]
    ]
}
