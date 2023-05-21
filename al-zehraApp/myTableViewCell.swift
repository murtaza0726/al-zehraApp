//
//  myTableViewCell.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-24.
//

import UIKit

class myTableViewCell: UITableViewCell {

    
    @IBOutlet var imageBookImage: UIImageView!
    @IBOutlet var bookNameDisplay: UILabel!
    @IBOutlet var author: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var descrip: UILabel!
    @IBOutlet var productStock: UILabel!
    @IBOutlet var imageRating: UIImageView!
    @IBOutlet var bookRatingNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)

        // Configure the view for the selected state
    }

}
