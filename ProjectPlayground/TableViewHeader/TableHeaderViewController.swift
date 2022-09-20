//
//  TableHeaderViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 5/31/22.
//

import UIKit

class TableHeaderViewController: UIViewController {
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var lastTableOffset: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SimpleTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Offset: \(tableView.contentOffset.y)")
        print("Constraint: \(headerHeightConstraint.constant)")
        print("Difference: \(lastTableOffset - tableView.contentOffset.y)")
        
        if tableView.contentOffset.y < 1 {
            
            if headerHeightConstraint.constant < 200 {
                headerHeightConstraint.constant += lastTableOffset - tableView.contentOffset.y
                tableView.contentOffset.y = 0
            }
        }
         
        if lastTableOffset < tableView.contentOffset.y {
            if tableView.contentOffset.y >= 0 && headerHeightConstraint.constant != 0 {
                headerHeightConstraint.constant -= tableView.contentOffset.y - lastTableOffset
                tableView.contentOffset.y = 0
            }
        }

        lastTableOffset = tableView.contentOffset.y
    }
}

extension TableHeaderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SimpleTableViewCell
        cell.titleLabel.text = "Index: \(indexPath.row)"
        return cell
    }
}
