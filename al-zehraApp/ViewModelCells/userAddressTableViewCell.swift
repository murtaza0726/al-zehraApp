//
//  userAddressTableViewCell.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-05-23.
//

import UIKit

class userAddressTableViewCell: UITableViewCell {

    
    @IBOutlet var userName: UILabel!
    @IBOutlet var userAddress: UILabel!
    @IBOutlet var userPhone: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
