//
//  Header.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 3/22/22.
//

import UIKit

class Header: UITableViewHeaderFooterView {
    let title = UILabel()
    let image = UIImageView()
    let arrow = UIImageView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        arrow.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(arrow)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            arrow.heightAnchor.constraint(equalToConstant: 30),
            arrow.widthAnchor.constraint(equalToConstant: 30),
            arrow.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 8),
            arrow.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            arrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
