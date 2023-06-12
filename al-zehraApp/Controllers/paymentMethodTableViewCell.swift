//
//  paymentMethodTableViewCell.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-11.
//

import UIKit

class paymentMethodTableViewCell: UITableViewCell {

    
    @IBOutlet var paymentLabel: UILabel!
    @IBOutlet var paymentImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
