//
//  TableViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 1/7/22.
//

import UIKit

class TableViewController: UIViewController, CellDelegate {
    @IBOutlet weak var tableView: UITableView!
    let names = ["Agent 1", "Agent 2", "Agent 3", "Agent 4", "Agent 5", "Agent 2", "Agent 3", "Agent 4", "Agent 5", "Agent 2", "Agent 3", "Agent 4", "Agent 5", "Agent 2", "Agent 3", "Agent 4", "Agent 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.register(UINib(nibName: "TableViewHeader", bundle: nil), forCellReuseIdentifier: "Header")
        tableView.register(UINib(nibName: "TableViewHeader2", bundle: nil), forHeaderFooterViewReuseIdentifier: "Header2")
    }
    
    func TableViewCell(name: String) {
        print(name)
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.label1.text = names[indexPath.row]
        cell.name = names[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableCell(withIdentifier: "Header") as! TableViewHeader
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header2") as! TableViewHeader2
        header.titleLabel.text = "OTHER HEADER"
        return header
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        let header = tableView.tableHeaderView as! TableViewHeader2
        header.titleLabel.text = "Woaw"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}
