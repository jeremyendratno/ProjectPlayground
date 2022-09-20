//
//  DnDCellCollectionViewCell.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 9/7/22.
//

import UIKit

class DnDCellCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.random
        contentView.cornerRadius(20)
    }
}
