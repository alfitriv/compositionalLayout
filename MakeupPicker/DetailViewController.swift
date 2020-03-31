//
//  DetailViewController.swift
//  MakeupPicker
//
//  Created by Vania Radmila Alfitri on 22/03/20.
//  Copyright © 2020 Vania Radmila Alfitri. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    var makeup: Makeup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        guard let makeup = makeup else {
            return
        }
        productTitleLabel.text = makeup.brand
        productCategoryLabel.text = makeup.productType?.rawValue
        let url = URL(string: makeup.imageLink ?? "")
        productImageView.kf.setImage(with: url)
    }

}
