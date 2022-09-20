//
//  ExpandingCellViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 3/18/22.
//

import UIKit

class ExpandingCellViewController: UIViewController {
    @IBOutlet weak var expandingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expandingTableView.register(UINib(nibName: "ExpandingTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        expandingTableView.dataSource = self
        expandingTableView.delegate = self
        expandingTableView.rowHeight = UITableView.automaticDimension
        expandingTableView.estimatedRowHeight = 50
    }
}

extension ExpandingCellViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expandingTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExpandingTableViewCell
        cell.titleLabel.text = "index: \(indexPath)"
        cell.data = ["test", "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest", "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest", "testtest", "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest","testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest","testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest","testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest","testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest",]
        cell.insideTableView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = expandingTableView.cellForRow(at: indexPath) as! ExpandingTableViewCell
        
        if cell.insideTableViewHeight.constant != 0 {
            cell.insideTableViewHeight.constant = 0
            UIView.animate(withDuration: 0.5) {
                self.expandingTableView.performBatchUpdates(nil)
            }
        } else {
            cell.insideTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: cell.insideTableView.frame.size.width, height: 1))
            cell.insideTableViewHeight.constant = cell.insideTableView.contentSize.height
            UIView.animate(withDuration: 0.5) {
                self.expandingTableView.performBatchUpdates(nil)
                self.expandingTableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
            }

//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
//                if cell.insideTableViewHeight.constant != cell.insideTableView.contentSize.height {
//                    cell.insideTableViewHeight.constant = cell.insideTableView.contentSize.height
//                    UIView.animate(withDuration: 0.5) {
//                        self.expandingTableView.performBatchUpdates(nil)
//                    }
//                }
//            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = expandingTableView.cellForRow(at: indexPath) as? ExpandingTableViewCell {
            cell.insideTableViewHeight.constant = 0
            UIView.animate(withDuration: 0.5) {
                self.expandingTableView.performBatchUpdates(nil)
            }
        }
    }
}
