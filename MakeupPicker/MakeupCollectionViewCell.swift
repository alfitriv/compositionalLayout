//
//  MakeupCollectionViewCell.swift
//  MakeupPicker
//
//  Created by Vania Radmila Alfitri on 22/03/20.
//  Copyright © 2020 Vania Radmila Alfitri. All rights reserved.
//

import UIKit
import Kingfisher

class MakeupCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var makeupImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView(_ makeup: Makeup) {
        let url = URL(string: makeup.imageLink ?? "")
        makeupImageView.kf.setImage(with: url)
    }

}
