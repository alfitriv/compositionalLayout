//
//  MakeupListCell.swift
//  MakeupPicker
//
//  Created by Vania Radmila Alfitri on 19/03/20.
//  Copyright © 2020 Vania Radmila Alfitri. All rights reserved.
//

import UIKit
import Kingfisher

class MakeupListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(_ makeup: Makeup) {
        let url = URL(string: makeup.imageLink ?? "")
        nameLabel.text = makeup.brand
        if let productType = makeup.productType?.rawValue {
            productTypeLabel.text = productType
        }
        productImageView.kf.setImage(with: url)
    }
    
}
