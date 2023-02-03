//
//  OpportunityCollectionViewCell.swift
//  NASAApp
//
//  Created by Şehriban Yıldırım on 30.01.2023.
//

import UIKit

class OpportunityCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var opportunityview: UIView!
    override func awakeFromNib() {
        opportunityview.layer.cornerRadius = 10
        imageview.layer.cornerRadius = 10
    }
}
