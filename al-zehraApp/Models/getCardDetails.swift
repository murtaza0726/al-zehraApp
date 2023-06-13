//
//  getCardDetails.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-12.
//

import Foundation

class cardDetails{
    var cardNumber: String
    var cardHolder: String
    var expiryDate: String
    var cvv: String
    
    init(cardNumber: String, cardHolder: String, expiryDate: String, cvv: String) {
        self.cardNumber = cardNumber
        self.cardHolder = cardHolder
        self.expiryDate = expiryDate
        self.cvv = cvv
    }
}
