//
//  CollectionRecursionViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 3/9/22.
//

import UIKit

class CollectionRecursionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = errorNih.dequeueReusableCell(withReuseIdentifier: "error", for: indexPath) as! ErrorCollectionViewCell
        cell.titleLabel.text = value[indexPath.row]
        cell.backView.layer.borderColor = UIColor.black.cgColor
        cell.backView.layer.borderWidth = 2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.value = ["OOOOO", "OOOOO", "OOOOO", "OOOOO", "OOOOO"]
        errorNih.reloadData()
    }
    
    @IBOutlet weak var errorNih: UICollectionView!
    var value = ["UAUAUAUA","UAUAUAUA","UAUAUAUA","UAUAUAUA","UAUAUAUA"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorNih.delegate = self
        errorNih.dataSource = self
        errorNih.register(UINib(nibName: "ErrorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "error")
    }
}
