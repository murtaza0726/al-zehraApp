//
//  HighlightCell.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-16.
//

import UIKit

class HighlightCell: UICollectionViewCell, OfferCell {
    static let reuseIdentifier = String(describing: HighlightCell.self)
    
    
    @IBOutlet var image: UIImageView!
    
    
    func showOffer(offer: OffersModel?){
        image.image = UIImage(named: offer?.headerImage ?? "")
    }
}
