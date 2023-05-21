//
//  cartTableViewCell.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-04-29.
//

import UIKit

class cartTableViewCell: UITableViewCell {
    
    
    @IBOutlet var imageURL: UIImageView!
    @IBOutlet var bookName: UILabel!
    @IBOutlet var authorName: UILabel!
    @IBOutlet var bookPrice: UILabel!
    @IBOutlet var descrips: UILabel!
    @IBOutlet var productStock: UILabel!
    @IBOutlet var productRating: UILabel!
    @IBOutlet var productRatingImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
