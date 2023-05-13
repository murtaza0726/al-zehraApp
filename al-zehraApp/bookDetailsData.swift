//
//  bookDetailsData.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-31.
//

import Foundation

class bookDetailsData{
    
    let title: String
    let auhtor: String
    let price:String
    //let imageURL:String
    let description: String
    
    init( title: String, auhtor: String, price: String, description: String) {
        //self.imageURL = imageURL
        self.title = title
        self.auhtor = auhtor
        self.price = price
        self.description = description
    }
}
