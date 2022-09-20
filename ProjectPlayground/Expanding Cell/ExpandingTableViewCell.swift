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
    var data: [String] = []
    
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
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = insideTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InsideTableViewCell
        cell.titleLabel.text = data[indexPath.row]
        
        return cell
    }
}
