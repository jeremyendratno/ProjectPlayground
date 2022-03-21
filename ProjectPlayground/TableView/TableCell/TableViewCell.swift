//
//  TableViewCell.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 1/7/22.
//

import UIKit

protocol CellDelegate: AnyObject {
    func TableViewCell(name: String)
}

class TableViewCell: UITableViewCell {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var label1: UILabel!
    
    var name: String?
    weak var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func button1(_ sender: Any) {
        delegate?.TableViewCell(name: name ?? "")
    }
    
}
