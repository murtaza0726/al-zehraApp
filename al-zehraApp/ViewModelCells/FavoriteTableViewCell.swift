//
//  FavoriteTableViewCell.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-05-17.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    
    @IBOutlet var imageURL: UIImageView!
    @IBOutlet var bookName: UILabel!
    @IBOutlet var authorName: UILabel!
    @IBOutlet var bookPrice: UILabel!
    @IBOutlet var descrips: UILabel!
    @IBOutlet var productStock: UILabel!
    @IBOutlet var bookRating: UILabel!
    @IBOutlet var bookRatingImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
