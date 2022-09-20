//
//  ExpendingCell2ViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 3/22/22.
//

import UIKit

class ExpendingCell2ViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var expendingTableView: UITableView!
    
    let data = [["some data", "some data", "some data", "some data", "some data"],
                ["some data", "some data some datasome data some data some data some data some datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome datasome data", "some data", "some data", "some data"],
                ["some data", "some data", "some data", "some data", "some data"],
                ["some data", "some data", "some data", "some data", "some data"],
                ["some data", "some data", "some data", "some data", "some data"],
                ["some data", "some data", "some data", "some data", "some data"],
                ["some data", "some data", "some data", "some data", "some data"],
                ["some data", "some data", "some data", "some data", "some data"],
                ["some data", "some data", "some data", "some data", "some data"],
                ["some data", "some data", "some data", "some data", "some data"],
                ["some data", "some data", "some data", "some data", "some data"],
                ["some data", "some data", "some data", "some data", "some data"],
                ["some data", "some data", "some data", "some data", "some data"],
                ["some data", "some data", "some data", "some data", "some data"],
                ["some data", "some data", "some data", "some data", "some data"]
    ]
    
    var openSection: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expendingTableView.delegate = self
        expendingTableView.dataSource = self
        expendingTableView.register(UINib(nibName: "Expending2TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        expendingTableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "header")
        expendingTableView.separatorStyle = .singleLine
    }
}

extension ExpendingCell2ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expendingTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Expending2TableViewCell
        cell.judul.text = data[indexPath.section][indexPath.row]
        
        if indexPath.row == data[indexPath.section].count - 1 {
            cell.contentView.layer.cornerRadius = 15
            cell.contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            cell.contentView.layer.cornerRadius = 0
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = expendingTableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! Header
        header.layer.backgroundColor = UIColor.white.cgColor
        header.layer.cornerRadius = 15
        
        if section == openSection {
            header.arrow.image = UIImage(systemName: "chevron.up")
            header.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            header.arrow.image = UIImage(systemName: "chevron.down")
            header.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
        
        header.title.text = "Some Header \(section)"
        header.image.image = UIImage(systemName: "circle.hexagonpath.fill")
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapRecognizer.name = "\(section)"
        header.addGestureRecognizer(tapRecognizer)
        return header
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let index = Int(sender.name ?? "-1") ?? -1
        let lastOpenSection = openSection
        
        if openSection == index {
            openSection = -1
        } else {
            openSection = index
        }
        
        if lastOpenSection != -1 && lastOpenSection == openSection {
            expendingTableView.reloadSections([lastOpenSection], with: .automatic)
        }
        
        expendingTableView.reloadSections([index], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == openSection {
            return UITableView.automaticDimension
        } else {
            return 0
        }
    }
}
