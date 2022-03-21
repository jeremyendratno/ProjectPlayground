//
//  ExpandingTableViewCell.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 3/18/22.
//

import UIKit

class ExpandingTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var insideTableView: UITableView!
    @IBOutlet weak var insideTableViewHeight: NSLayoutConstraint!
    var height: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        insideTableView.register(UINib(nibName: "InsideTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        insideTableView.estimatedRowHeight = 50
        insideTableView.rowHeight = UITableView.automaticDimension
        insideTableView.dataSource = self
        insideTableView.delegate = self
    }
}

extension ExpandingTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = insideTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InsideTableViewCell
        
        if indexPath.row == 1 {
            cell.titleLabel.text = "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest"
        } else if indexPath.row == 3 {
            cell.titleLabel.text = "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest"
        } else {
            cell.titleLabel.text = "testtesttesttest"
        }
        
        if indexPath.row == 4 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0)
        }
        
        return cell
    }
}
