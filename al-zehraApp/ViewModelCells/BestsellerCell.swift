//
//  BestsellerCell.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-18.
//

import UIKit

class BestsellerCell: UICollectionViewCell, OfferCell {
    
    static let reuseIdentifier = String(describing: BestsellerCell.self)
    
    @IBOutlet var bestsellerImage: UIImageView!
    
    func showOffer(offer: OffersModel?) {
        bestsellerImage.image = UIImage(named: offer?.headerImage ?? "")
    }
    
    
}
