//
//  userDetails.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-05-22.
//

import Foundation

class userDetails{
    var firstName: String
    var LastName: String
    var phone: String
    var email: String
    var password: String
    var userUID: String
    var addressLine1: String
    var addressLine2: String
    var postalCode: String
    var city: String
    
    init(firstName: String, LastName: String, phone: String, email: String, password: String, userUID: String, addressLine1: String, addressLine2: String, postalCode: String, city: String) {
        self.firstName = firstName
        self.LastName = LastName
        self.phone = phone
        self.email = email
        self.password = password
        self.userUID = userUID
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.postalCode = postalCode
        self.city = city
    }
}
