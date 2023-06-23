//
//  Offers.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-16.
//

import Foundation
import UIKit

struct OffersModel: Hashable{
    
    let title: String
    let headerImage: String
    let thumbnail: UIImage?
    
    let identifier = UUID().uuidString
    
    init(title: String, headerImage: String, thumbnail: UIImage? = nil) {
        self.title = title
        self.headerImage = headerImage
        self.thumbnail = thumbnail
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: OffersModel, rhs: OffersModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
