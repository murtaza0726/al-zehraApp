//
//  OrderHistoryTableViewCell.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-07-03.
//

import UIKit

class OrderHistoryTableViewCell: UITableViewCell {

    
    @IBOutlet var bookName: UILabel!
    @IBOutlet var orderDate: UILabel!
    @IBOutlet var imageURL: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
