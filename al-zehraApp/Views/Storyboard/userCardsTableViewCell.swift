//
//  userCardsTableViewCell.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-13.
//

import UIKit

class userCardsTableViewCell: UITableViewCell {

    
    @IBOutlet var cardImage: UIImageView!
    @IBOutlet var cardNumberLabel: UILabel!
    @IBOutlet var cardHolder: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
