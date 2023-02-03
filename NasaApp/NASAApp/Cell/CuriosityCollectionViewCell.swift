//
//  CuriosityCollectionViewCell.swift
//  NASAApp
//
//  Created by Şehriban Yıldırım on 30.01.2023.
//

import UIKit

class CuriosityCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var curiosityview: UIView!
    override func awakeFromNib() {
        curiosityview.layer.cornerRadius = 10
        imageview.layer.cornerRadius = 10
    }
}
