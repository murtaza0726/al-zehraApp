//
//  PreviewViewCell.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-18.
//

import UIKit

class PreviewCell: UICollectionViewCell, OfferCell {
    
    static let reuseIdentifier = String(describing: PreviewCell.self)
    
    
    @IBOutlet var authorImage: UIImageView!
    @IBOutlet var authorLabel: UILabel!
    
    var gradientAdded = false
    
    func showOffer(offer: OffersModel?) {
        
        authorImage.makeRound(borderColor: .init(red: 0, green: 10, blue: 0, alpha: 10) )
        
        
        if !gradientAdded{
            gradientAdded = true
            authorImage.addGradient()
        }
        
        authorImage.image = UIImage(named: offer?.headerImage ?? "")
        authorLabel.text = offer?.bookName
    }
    
    
}

