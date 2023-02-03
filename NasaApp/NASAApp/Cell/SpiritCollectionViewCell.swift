//
//  SpiritCollectionViewCell.swift
//  NASAApp
//
//  Created by Şehriban Yıldırım on 30.01.2023.
//

import UIKit

class SpiritCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imagevieww: UIImageView!
    @IBOutlet weak var spiritview: UIView!
    override func awakeFromNib() {
        spiritview.layer.cornerRadius = 10
        imagevieww.layer.cornerRadius = 10
    }
}
