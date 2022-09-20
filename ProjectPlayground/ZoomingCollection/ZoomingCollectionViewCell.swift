//
//  ZoomingCollectionViewCell.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 9/12/22.
//

import UIKit

class ZoomingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var someView: UIView!
    @IBOutlet weak var theTitle: UILabel!
    
    override func prepareForReuse() {
        theTitle.isHidden = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(color: UIColor, isViewed: Bool) {
        someView.backgroundColor = color
        someView.cornerRadius(20)
        theTitle.text = color.getHexString()
        
        if isViewed {
            theTitle.isHidden = false
        } else {
            theTitle.isHidden = true
        }
    }
}
