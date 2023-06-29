//
//  selectPaymentMethodCell.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-27.
//

import UIKit

class selectPaymentMethodCell: UITableViewCell {

    
    @IBOutlet var cardNumber: UILabel!
    @IBOutlet var cardHolder: UILabel!
    @IBOutlet var cardImageCode: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
