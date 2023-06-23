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
    
//    static var offersAd =
//
//    [OffersModel]()

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
            OffersModel(title: "R. Tagore", headerImage: "author-1"),
            OffersModel(title: "Albert Einstein", headerImage: "author-2"),
            OffersModel(title: "C.V Raman", headerImage: "author-3"),
            OffersModel(title: "Kazuo Ishiguro", headerImage: "author-4")
        ],
        Section.AUTHOR:
        [
            OffersModel(title: "Arundhati Roy", headerImage: "author-5"),
            OffersModel(title: "Barack Obama", headerImage: "author-6"),
            OffersModel(title: "V.E Schwab", headerImage: "author-7"),
            OffersModel(title: "Mother Terressa", headerImage: "author-8")
        ],
        Section.CATEGORY:
        [
            OffersModel(title: "Jay Kristoff", headerImage: "author-9"),
            OffersModel(title: "Aravind Adiga", headerImage: "author-10"),
            OffersModel(title: "R. Tagore", headerImage: "author-1"),
            OffersModel(title: "Albert Einstein", headerImage: "author-2")
        ],
        Section.BESTSELLER:
        [
            OffersModel(title: "C.V Raman", headerImage: "author-3"),
            OffersModel(title: "Kazuo Ishiguro", headerImage: "author-4"),
            OffersModel(title: "Arundhati Roy", headerImage: "author-5"),
            OffersModel(title: "Barack Obama", headerImage: "author-6")
        ]
    ]
}
