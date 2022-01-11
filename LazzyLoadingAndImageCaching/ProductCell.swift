//
//  ProductCell.swift
//  LazzyLoadingAndImageCaching
//
//  Created by Mac on 11/01/22.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImage: LazzyImageView!
    @IBOutlet weak var productName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
